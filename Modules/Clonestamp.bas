Attribute VB_Name = "Tools_Clone"
'***************************************************************************
'Clone stamp tool interface
'Copyright 2019-2019 by Tanner Helland
'Created: 16/September/19
'Last updated: 20/September/19
'Last update: add "sample merged" option
'
'The clone tool is nearly identical to the standard soft brush tool.  The only difference is in how the
' source overlay is calculated (e.g. instead of a solid fill, it samples from a source image/layer).
'
'All source code in this file is licensed under a modified BSD license.  This means you may use the code in your own
' projects IF you provide attribution.  For more information, please visit https://photodemon.org/license/
'
'***************************************************************************

Option Explicit

'The current brush engine is stored here.  Note that this value is not correct until a call has been made to
' the CreateCurrentBrush() function; this function searches brush attributes and determines which brush engine
' to use.
Private m_BrushOutlinePath As pd2DPath

'Brush resources, used only as necessary.  Check for null values before using.
Private m_SrcPenDIB As pdDIB
Private m_Mask() As Byte, m_MaskSize As Long

'Brush attributes are stored in these variables
Private m_BrushSource As PD_BrushSource
Private m_BrushSize As Single
Private m_BrushOpacity As Single
Private m_BrushBlendmode As PD_BlendMode
Private m_BrushAlphamode As PD_AlphaMode
Private m_BrushAntialiasing As PD_2D_Antialiasing
Private m_BrushHardness As Single
Private m_BrushSpacing As Single
Private m_BrushFlow As Single

'Note that some brush attributes only exist for certain brush sources.
Private m_BrushSourceColor As Long

'If brush properties have changed since the last brush creation, this is set to FALSE.  We use this to optimize
' brush creation behavior.
Private m_BrushIsReady As Boolean
Private m_BrushCreatedAtLeastOnce As Boolean

'Current mouse/pen input values.  These are blindly relayed to us by the canvas, and it's up to us to perform any
' special tracking calculations.
Private m_MouseX As Single, m_MouseY As Single
Private Const MOUSE_OOB As Single = -9.99999E+14!

'If the shift key is being held down, we draw a different type of preview
Private m_ShiftKeyDown As Boolean

'Brush dynamics are calculated on-the-fly, and they include things like velocity, distance, angle, and more.
Private m_DistPixels As Long, m_BrushSizeInt As Long
Private m_BrushSpacingCheck As Long

'As brush movements are relayed to us, we keep a running note of the modified area of the scratch layer.
' The compositor can use this information to only regenerate the compositor cache area that's changed since the
' last repaint event.  Note that the m_ModifiedRectF may be cleared between accesses, by design - you'll need to
' keep an eye on your usage of parameters in the GetModifiedUpdateRectF function.
'
'If you want the absolute modified area since the stroke began, you can use m_TotalModifiedRectF, which is not
' cleared until the current stroke is released.
Private m_UnionRectRequired As Boolean
Private m_ModifiedRectF As RectF, m_TotalModifiedRectF As RectF

'pd2D is used for certain brush styles
Private m_Surface As pd2DSurface

'A dedicated class produces the actual dab coordinates for us, from mouse events we've forwarded to it
Private m_Paintbrush As pdPaintbrush

'If a source point exists, this will be set to TRUE.  Unlike other paint tools, the clone tool source
' does *not* reset when switching between images, which creates some complicates - namely, we must always
' check that the source image+layer combination still exists!
Private m_SourceExists As Boolean

'The user can clone from a *different* source or *different* layer!  (Note that the layer setting can
' be overridden by the Sample Merged setting)
Private m_SourceImageID As Long, m_SourceLayerID As Long
Private m_SourcePoint As PointFloat, m_SourceSetThisClick As Boolean
Private m_SourceOffsetX As Single, m_SourceOffsetY As Single
Private m_SampleMerged As Boolean, m_SampleMergedCopy As pdDIB
Private m_Sample As pdDIB, m_SampleUntouched As pdDIB
Private m_CtrlKeyDown As Boolean

Public Function GetBrushPreviewQuality_GDIPlus() As GP_InterpolationMode
    If (g_ViewportPerformance = PD_PERF_FASTEST) Then
        GetBrushPreviewQuality_GDIPlus = GP_IM_NearestNeighbor
    ElseIf (g_ViewportPerformance = PD_PERF_BESTQUALITY) Then
        GetBrushPreviewQuality_GDIPlus = GP_IM_HighQualityBicubic
    Else
        GetBrushPreviewQuality_GDIPlus = GP_IM_Bilinear
    End If
End Function

'Universal brush settings, applicable for most sources.  (I say "most" because some settings can contradict each other;
' for example, a "locked" alpha mode + "erase" blend mode makes little sense, but it is technically possible to set
' those values simultaneously.)
Public Function GetBrushAlphaMode() As PD_AlphaMode
    GetBrushAlphaMode = m_BrushAlphamode
End Function

Public Function GetBrushAntialiasing() As PD_2D_Antialiasing
    GetBrushAntialiasing = m_BrushAntialiasing
End Function

Public Function GetBrushBlendMode() As PD_BlendMode
    GetBrushBlendMode = m_BrushBlendmode
End Function

Public Function GetBrushFlow() As Single
    GetBrushFlow = m_BrushFlow
End Function

Public Function GetBrushHardness() As Single
    GetBrushHardness = m_BrushHardness
End Function

Public Function GetBrushOpacity() As Single
    GetBrushOpacity = m_BrushOpacity
End Function

Public Function GetBrushSampleMerged() As Boolean
    GetBrushSampleMerged = m_SampleMerged
End Function

Public Function GetBrushSize() As Single
    GetBrushSize = m_BrushSize
End Function

Public Function GetBrushSource() As PD_BrushSource
    GetBrushSource = m_BrushSource
End Function

Public Function GetBrushSourceColor() As Long
    GetBrushSourceColor = m_BrushSourceColor
End Function

Public Function GetBrushSpacing() As Single
    GetBrushSpacing = m_BrushSpacing
End Function

'Property set functions.  Note that not all brush properties are used by all styles.
' (e.g. "brush hardness" is not used by "pencil" style brushes, etc)
Public Sub SetBrushAlphaMode(Optional ByVal newAlphaMode As PD_AlphaMode = LA_NORMAL)
    If (newAlphaMode <> m_BrushAlphamode) Then
        m_BrushAlphamode = newAlphaMode
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushAntialiasing(Optional ByVal newAntialiasing As PD_2D_Antialiasing = P2_AA_HighQuality)
    If (newAntialiasing <> m_BrushAntialiasing) Then
        m_BrushAntialiasing = newAntialiasing
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushBlendMode(Optional ByVal newBlendMode As PD_BlendMode = BL_NORMAL)
    If (newBlendMode <> m_BrushBlendmode) Then
        m_BrushBlendmode = newBlendMode
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushFlow(Optional ByVal newFlow As Single = 100#)
    If (newFlow <> m_BrushFlow) Then
        m_BrushFlow = newFlow
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushHardness(Optional ByVal newHardness As Single = 100#)
    newHardness = newHardness * 0.01
    If (newHardness <> m_BrushHardness) Then
        m_BrushHardness = newHardness
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushOpacity(ByVal newOpacity As Single)
    If (newOpacity <> m_BrushOpacity) Then
        m_BrushOpacity = newOpacity
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushSampleMerged(ByVal newState As Boolean)
    If (newState <> m_SampleMerged) Then
        m_SampleMerged = newState
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushSize(ByVal newSize As Single)
    If (newSize <> m_BrushSize) Then
        m_BrushSize = newSize
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushSource(ByVal newSource As PD_BrushSource)
    If (newSource <> m_BrushSource) Then
        m_BrushSource = newSource
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushSourceColor(Optional ByVal newColor As Long = vbWhite)
    If (newColor <> m_BrushSourceColor) Then
        m_BrushSourceColor = newColor
        m_BrushIsReady = False
    End If
End Sub

Public Sub SetBrushSpacing(ByVal newSpacing As Single)
    newSpacing = newSpacing * 0.01
    If (newSpacing <> m_BrushSpacing) Then
        m_BrushSpacing = newSpacing
        m_BrushIsReady = False
    End If
End Sub

Public Function GetBrushProperty(ByVal bProperty As PD_BrushAttributes) As Variant
    
    Select Case bProperty
        Case BA_AlphaMode
            GetBrushProperty = GetBrushAlphaMode()
        Case BA_Antialiasing
            GetBrushProperty = GetBrushAntialiasing()
        Case BA_BlendMode
            GetBrushProperty = GetBrushBlendMode()
        Case BA_Flow
            GetBrushProperty = GetBrushFlow()
        Case BA_Hardness
            GetBrushProperty = GetBrushHardness()
        Case BA_Opacity
            GetBrushProperty = GetBrushOpacity()
        Case BA_Size
            GetBrushProperty = GetBrushSize()
        Case BA_Source
            GetBrushProperty = GetBrushSource()
        Case BA_SourceColor
            GetBrushProperty = GetBrushSourceColor()
        Case BA_Spacing
            GetBrushProperty = GetBrushSpacing()
    End Select
    
End Function

Public Sub SetBrushProperty(ByVal bProperty As PD_BrushAttributes, ByVal newPropValue As Variant)
    
    Select Case bProperty
        Case BA_AlphaMode
            SetBrushAlphaMode newPropValue
        Case BA_Antialiasing
            SetBrushAntialiasing newPropValue
        Case BA_BlendMode
            SetBrushBlendMode newPropValue
        Case BA_Flow
            SetBrushFlow newPropValue
        Case BA_Hardness
            SetBrushHardness newPropValue
        Case BA_Opacity
            SetBrushOpacity newPropValue
        Case BA_Size
            SetBrushSize newPropValue
        Case BA_Source
            SetBrushSource newPropValue
        Case BA_SourceColor
            SetBrushSourceColor newPropValue
        Case BA_Spacing
            SetBrushSpacing newPropValue
    End Select
    
End Sub

Private Sub CreateCurrentBrush(Optional ByVal alsoCreateBrushOutline As Boolean = True, Optional ByVal forceCreation As Boolean = False)
        
    If ((Not m_BrushIsReady) Or forceCreation Or (Not m_BrushCreatedAtLeastOnce)) Then
    
        Dim startTime As Currency
        VBHacks.GetHighResTime startTime

        'Build a new brush reference image that reflects the current brush properties
        m_BrushSizeInt = Int(m_BrushSize + 0.999999)
        CreateSoftBrushReference_PD
        
        'We also need to calculate a brush spacing reference.  A spacing of 1 means that every pixel in
        ' the current stroke is dabbed.  From a performance perspective, this is simply not feasible for
        ' large brushes, so avoid it if possible.
        '
        'The "Automatic" setting (which maps to spacing = 0) automatically calculates spacing based on
        ' the current brush size.  (Basically, we dab every 1/2pi of a radius.)
        Dim tmpBrushSpacing As Single
        tmpBrushSpacing = m_BrushSize / PI_DOUBLE
        
        If (m_BrushSpacing > 0#) Then
            tmpBrushSpacing = (m_BrushSpacing * tmpBrushSpacing)
        End If
        
        'The module-level spacing check is an integer (because we Mod it to test for paint dabs)
        m_BrushSpacingCheck = Int(tmpBrushSpacing + 0.5)
        If (m_BrushSpacingCheck < 1) Then m_BrushSpacingCheck = 1
        
        'Whenever we create a new brush, we should also refresh the current brush outline
        If alsoCreateBrushOutline Then CreateCurrentBrushOutline
        
        m_BrushIsReady = True
        m_BrushCreatedAtLeastOnce = True
        
        PDDebug.LogAction "Tools_Clone.CreateCurrentBrush took " & VBHacks.GetTimeDiffNowAsString(startTime)
        
    End If
    
End Sub

Private Sub CreateSoftBrushReference_PD()
    
    'Initialize our reference DIB as necessary
    If (m_SrcPenDIB Is Nothing) Then Set m_SrcPenDIB = New pdDIB
    If (m_SrcPenDIB.GetDIBWidth < m_BrushSizeInt) Or (m_SrcPenDIB.GetDIBHeight < m_BrushSizeInt) Then
        m_SrcPenDIB.CreateBlank m_BrushSizeInt, m_BrushSizeInt, 32, 0, 0
    Else
        m_SrcPenDIB.ResetDIB 0
    End If
    
    'Next, check for a few special cases.  First, brushes with maximum hardness don't need to be rendered manually.
    ' Instead, just plot an antialiased circle and call it good.
    Dim cSurface As pd2DSurface, cBrush As pd2DBrush
    If (m_BrushHardness = 1#) Then
        
        Drawing2D.QuickCreateSurfaceFromDC cSurface, m_SrcPenDIB.GetDIBDC, True
        cSurface.SetSurfacePixelOffset P2_PO_Half
        
        Drawing2D.QuickCreateSolidBrush cBrush, m_BrushSourceColor, m_BrushFlow
        PD2D.FillCircleF cSurface, cBrush, m_BrushSize * 0.5, m_BrushSize * 0.5, m_BrushSize * 0.5
        
        Set cBrush = Nothing: Set cSurface = Nothing
    
    'If a brush has custom hardness, we're gonna have to render it manually.
    Else
        
        'Because we are only setting 255 possible different colors (one for each possible opacity, while the current
        ' color remains constant), this is a great candidate for lookup tables.  Note that for performance reasons,
        ' we're going to do something wacky, and prep our lookup table as *longs*.  This is (obviously) faster than
        ' setting each byte individually.
        Dim tmpR As Long, tmpG As Long, tmpB As Long
        tmpR = Colors.ExtractRed(m_BrushSourceColor)
        tmpG = Colors.ExtractGreen(m_BrushSourceColor)
        tmpB = Colors.ExtractBlue(m_BrushSourceColor)
        
        Dim cLookup() As Long
        ReDim cLookup(0 To 255) As Long
        
        'Calculate brush flow (which controls the opacity of individual dabs)
        Dim normMult As Single, flowMult As Single
        flowMult = m_BrushFlow * 0.01
        normMult = (1# / 255#) * flowMult
        
        Dim x As Long, y As Long, tmpMult As Single
        For x = 0 To 255
            tmpMult = CSng(x) * normMult
            cLookup(x) = GDI_Plus.FillLongWithRGBA(tmpMult * tmpR, tmpMult * tmpG, tmpMult * tmpB, x * flowMult)
        Next x
        
        'Next, we're going to do something weird.  If this brush is quite small, it's very difficult to plot subpixel
        ' data accurately.  Instead of messing with specialized calculations, we're just going to plot a larger
        ' temporary brush, then resample it down to the target size.  This is the least of many evils.
        Dim tmpBrushRequired As Boolean, tmpDIB As pdDIB
        Const BRUSH_SIZE_MIN_CUTOFF As Long = 15
        tmpBrushRequired = (m_BrushSize < BRUSH_SIZE_MIN_CUTOFF)
        
        'Prep manual per-pixel loop variables
        Dim dstImageData() As Long, tmpSA As SafeArray1D
        
        If tmpBrushRequired Then
            Set tmpDIB = New pdDIB
            tmpDIB.CreateBlank BRUSH_SIZE_MIN_CUTOFF, BRUSH_SIZE_MIN_CUTOFF, 32, 0, 0
        End If
        
        Dim initX As Long, initY As Long, finalX As Long, finalY As Long
        initX = 0
        initY = 0
        
        'For small brush sizes, we use the larger "temporary DIB" size as our target; the final result will be
        ' downsampled at the end.
        If tmpBrushRequired Then
            finalX = tmpDIB.GetDIBWidth - 1
            finalY = tmpDIB.GetDIBHeight - 1
        Else
            finalX = m_SrcPenDIB.GetDIBWidth - 1
            finalY = m_SrcPenDIB.GetDIBHeight - 1
        End If
        
        'After a good deal of testing, I've decided that I don't like the MyPaint system for calculating brush hardness.
        ' Their system behaves ridiculously at low "hardness" values, causing huge spacing issues for the brush.
        ' Instead, I'm using a system similar to PD's "vignette" tool, which yields much better results for beginners, IMO.
        Dim brushHardness As Single
        brushHardness = m_BrushHardness
        
        'Calculate interior and exterior brush radii.  Any pixels...
        ' - OUTSIDE the EXTERIOR radius are guaranteed to be fully transparent
        ' - INSIDE the INTERIOR radius are guaranteed to be fully opaque (or whatever the equivalent "max opacity" is for
        '    the current brush flow rate)
        ' - BETWEEN the exterior and interior radii will be feathered accordingly
        Dim brushRadius As Single, brushRadiusSquare As Single
        If tmpBrushRequired Then
            brushRadius = CSng(BRUSH_SIZE_MIN_CUTOFF) * 0.5
        Else
            brushRadius = m_BrushSize * 0.5
        End If
        brushRadiusSquare = brushRadius * brushRadius
        
        Dim innerRadius As Single, innerRadiusSquare As Single
        innerRadius = (brushRadius - 1) * (brushHardness * 0.99)
        innerRadiusSquare = innerRadius * innerRadius
        
        Dim radiusDifference As Single
        radiusDifference = (brushRadiusSquare - innerRadiusSquare)
        If (radiusDifference < 0.00001) Then radiusDifference = 0.00001
        radiusDifference = (1# / radiusDifference)
        
        Dim cx As Single, cy As Single
        Dim pxDistance As Single, pxOpacity As Single
        
        'Loop through each pixel in the image, calculating per-pixel brush values as we go
        For y = initY To finalY
            If tmpBrushRequired Then
                tmpDIB.WrapLongArrayAroundScanline dstImageData, tmpSA, y
            Else
                m_SrcPenDIB.WrapLongArrayAroundScanline dstImageData, tmpSA, y
            End If
        For x = initX To finalX
        
            'Calculate distance between this point and the idealized "center" of the brush
            cx = x - brushRadius
            cy = y - brushRadius
            pxDistance = (cx * cx + cy * cy)
            
            'Ignore pixels that lie outside the brush radius.  (These were initialized to full transparency,
            ' and we're simply gonna leave them that way.)
            If (pxDistance <= brushRadiusSquare) Then
                
                'If pixels lie *inside* the inner radius, set them to maximum opacity
                If (pxDistance <= innerRadiusSquare) Then
                    dstImageData(x) = cLookup(255)
                
                'If pixels lie somewhere between the inner radius and the brush radius, feather them appropriately
                Else
                
                    'Calculate the current distance as a linear amount between the inner radius (the smallest amount
                    ' of feathering this hardness value provides), and the outer radius (the actual brush radius)
                    pxOpacity = (brushRadiusSquare - pxDistance) * radiusDifference
                    
                    'Cube the result to produce a more gaussian-like fade
                    pxOpacity = pxOpacity * pxOpacity * pxOpacity
                    
                    'Pull the matching result from our lookup table
                    dstImageData(x) = cLookup(pxOpacity * 255#)
                    
                End If
                
            End If
        
        Next x
        Next y
        
        'Safely deallocate imageData()
        If tmpBrushRequired Then
            tmpDIB.UnwrapLongArrayFromDIB dstImageData
        Else
            m_SrcPenDIB.UnwrapLongArrayFromDIB dstImageData
        End If
        
        'If a temporary brush was required (because the target brush is so small), downscale it to its
        ' final size now.
        If tmpBrushRequired Then
            GDI_Plus.GDIPlus_StretchBlt m_SrcPenDIB, 0#, 0#, m_BrushSize, m_BrushSize, tmpDIB, 0#, 0#, BRUSH_SIZE_MIN_CUTOFF, BRUSH_SIZE_MIN_CUTOFF, , GP_IM_HighQualityBilinear, , , True, True
        End If
        
    End If
    
    'Brushes are always premultiplied
    m_SrcPenDIB.SetInitialAlphaPremultiplicationState True
    
    'We now want to do something unique to the clone brush.  We don't actually need a full image for the
    ' brush source (as we're going to be producing one "on the fly" using the base image's pixels) - so instead
    ' of maintaining a full mask, just copy the relevant alpha bytes into a dedicated byte array.
    
    'Why not just produce a byte array in the first place, you ask?  Because we want this brush to produce
    ' identical border results to a standard brush, which means we want to mimic GDI+ antialiasing precisely -
    ' so we still need to lean on it for conditions like tiny brushes or 100% hardness brushes.
    If (m_MaskSize = 0) Or (m_MaskSize <> m_BrushSizeInt) Then
        m_MaskSize = m_BrushSizeInt
        ReDim m_Mask(0 To m_MaskSize - 1, 0 To m_MaskSize - 1) As Byte
    Else
        FillMemory VarPtr(m_Mask(0, 0)), m_MaskSize * m_MaskSize, 0
    End If
    
    For y = 0 To m_MaskSize - 1
        m_SrcPenDIB.WrapLongArrayAroundScanline dstImageData, tmpSA, y
    For x = 0 To m_MaskSize - 1
        m_Mask(x, y) = dstImageData(x) And &HFF&
    Next x
    Next y
    
    m_SrcPenDIB.UnwrapLongArrayFromDIB dstImageData

End Sub

'As part of rendering the current brush, we also need to render a brush outline onto the canvas at the current
' mouse location.  The specific outline technique used varies by brush engine.
Private Sub CreateCurrentBrushOutline()

    'TODO!  Right now this is just a copy+paste of the GDI+ outline algorithm; we obviously need a more sophisticated
    ' one in the future.
    Set m_BrushOutlinePath = New pd2DPath
    
    'Single-pixel brushes are treated as a square for cursor purposes.
    If (m_BrushSize > 0#) Then
        If (m_BrushSize = 1) Then
            m_BrushOutlinePath.AddRectangle_Absolute -0.75, -0.75, 0.75, 0.75
        Else
            m_BrushOutlinePath.AddCircle 0, 0, m_BrushSize / 2 + 0.5
        End If
    End If

End Sub

'Notify the brush engine of the current mouse position.  Coordinates should always be in *image* coordinate space,
' not screen space.  (Translation between spaces will be handled internally.)
Public Sub NotifyBrushXY(ByVal mouseButtonDown As Boolean, ByVal Shift As ShiftConstants, ByVal srcX As Single, ByVal srcY As Single, ByVal mouseTimeStamp As Long, ByRef srcCanvas As pdCanvas)
    
    'Couple things - first, determine if the CTRL key is being pressed alongside a mouse button.
    ' If it is, the user is setting a new anchor point.
    If ((Shift And vbCtrlMask) = vbCtrlMask) Then
        
        m_CtrlKeyDown = True
        m_MouseX = srcX
        m_MouseY = srcY
        
        If mouseButtonDown Then
            
            'Mark the current image, layer, and location
            m_SourceExists = True
            m_SourceImageID = PDImages.GetActiveImageID
            m_SourceLayerID = PDImages.GetActiveImage.GetActiveLayerID
            m_SourcePoint.x = srcX
            m_SourcePoint.y = srcY
            
        End If
        
        m_SourceSetThisClick = True
        
        'Nothing else needs to be done here; exit immediately
        Exit Sub
        
    Else
        Message "Ctrl+Click to set clone source", "DONOTLOG"
        m_CtrlKeyDown = False
    End If
    
    'Relay this action to the brush engine; it calculates dab positions for us.
    m_Paintbrush.NotifyBrushXY mouseButtonDown, Shift, srcX, srcY, mouseTimeStamp
    
    'Reset source-set mode
    If m_Paintbrush.IsFirstDab And (Not m_CtrlKeyDown) Then m_SourceSetThisClick = False
    
    'Regardless of mouse button state (up *or* down), cache a local copy of mouse coords; we require these for
    ' rendering a brush outline.
    
    'Perform a failsafe check for brush creation
    If (Not m_BrushIsReady) Then CreateCurrentBrush
    
    'If this is a MouseDown operation, we need to make sure the full paint engine is synchronized
    ' against any property changes that are applied "on-demand" - but for this clone brush, we only
    ' do this if a valid source point has been set!
    If m_Paintbrush.IsFirstDab() And m_SourceExists Then
        
        'Switch the target canvas into high-resolution, non-auto-drop mode.  This basically means the mouse tracker
        ' reconstructs full mouse movement histories via GetMouseMovePointsEx, and it reports every last event to us,
        ' regardless of the delays involved.  (Normally, as mouse events become increasingly delayed, they are
        ' auto-dropped until the processor catches up.  We have other ways of working around that problem in the
        ' brush engine.)
        '
        'IMPORTANT NOTE: VirtualBox returns bad data via GetMouseMovePointsEx, so I now expose this setting to the user
        ' via the Tools > Options menu.  If the user disables high-res input, we will also ignore it.
        srcCanvas.SetMouseInput_HighRes Tools.GetToolSetting_HighResMouse()
        srcCanvas.SetMouseInput_AutoDrop False
        
        'Make sure the current scratch layer is properly initialized
        Tools.InitializeToolsDependentOnImage
        PDImages.GetActiveImage.ScratchLayer.SetLayerOpacity m_BrushOpacity
        PDImages.GetActiveImage.ScratchLayer.SetLayerBlendMode m_BrushBlendmode
        PDImages.GetActiveImage.ScratchLayer.SetLayerAlphaMode m_BrushAlphamode
        PDImages.GetActiveImage.ScratchLayer.layerDIB.SetInitialAlphaPremultiplicationState True
        
        'Reset the "last mouse position" values to match the current ones
        m_MouseX = srcX
        m_MouseY = srcY
        
        'Calculate an offset from the current point to the source point; this is maintained
        ' for the duration of this stroke.
        m_SourceOffsetX = (m_SourcePoint.x - m_MouseX)
        m_SourceOffsetY = (m_SourcePoint.y - m_MouseY)
        
        'Notify the central "color history" manager of the color currently being used
        If (m_BrushSource = BS_Color) Then UserControls.PostPDMessage WM_PD_PRIMARY_COLOR_APPLIED, m_BrushSourceColor, , True
        
        'Initialize any relevant GDI+ objects for the current brush
        Drawing2D.QuickCreateSurfaceFromDC m_Surface, PDImages.GetActiveImage.ScratchLayer.layerDIB.GetDIBDC, (m_BrushAntialiasing = P2_AA_HighQuality)
        
        'Reset any brush dynamics that are calculated on a per-stroke basis
        m_DistPixels = 0
        
        'If "sample merged" is active, retrieve said merged sample now
        If m_SampleMerged Then
            
            'If the source image is a single-layer image, skip making a copy and instead just point the
            ' object directly at the source layer.  (The copy is *never* modified.)
            Dim mergeShortcutOK As Boolean
            mergeShortcutOK = (PDImages.GetImageByID(m_SourceImageID).GetNumOfLayers = 1)
            If mergeShortcutOK Then mergeShortcutOK = (Not PDImages.GetImageByID(m_SourceImageID).GetLayerByID(m_SourceLayerID).AffineTransformsActive(True))
            If mergeShortcutOK Then
                Set m_SampleMergedCopy = PDImages.GetImageByID(m_SourceImageID).GetLayerByID(m_SourceLayerID).layerDIB
            Else
                If (m_SampleMergedCopy Is Nothing) Then Set m_SampleMergedCopy = New pdDIB
                PDImages.GetImageByID(m_SourceImageID).GetCompositedImage m_SampleMergedCopy, True
            End If
            
        End If
        
    End If
    
    'Next, determine if the shift key is being pressed.  If it is, and if the user has already committed a
    ' brush stroke to this image (on a previous paint tool event), we want to draw a smooth line between the
    ' last paint point and the current one.  Note that this special condition is stored at module level,
    ' as we render a custom UI on mouse move events if the mouse button is *not* pressed, to help communicate
    ' what the shift key does.
    m_ShiftKeyDown = ((Shift And vbShiftMask) <> 0)
    
    Dim startTime As Currency
    
    'If the mouse button is down, perform painting between the old and new points.
    ' (All painting occurs in image coordinate space, and is applied to the current image's scratch layer.)
    If (mouseButtonDown Or m_Paintbrush.IsLastDab()) And m_SourceExists Then
    
        'Want to profile this function?  Use this line of code (and the matching report line at the bottom of the function).
        VBHacks.GetHighResTime startTime
        
        'See if there are more points in the mouse move queue.  If there are, grab them all and stroke them immediately.
        Dim numPointsRemaining As Long
        numPointsRemaining = srcCanvas.GetNumMouseEventsPending
        
        If (numPointsRemaining > 0) And (Not m_Paintbrush.IsFirstDab()) Then
        
            Dim tmpMMP As MOUSEMOVEPOINT
            Dim imgX As Double, imgY As Double
            
            Do While srcCanvas.GetNextMouseMovePoint(VarPtr(tmpMMP))
                
                'The (x, y) points returned by this request are in the *hWnd's* coordinate space.  We must manually convert them
                ' to the image coordinate space.
                If Drawing.ConvertCanvasCoordsToImageCoords(srcCanvas, PDImages.GetActiveImage(), tmpMMP.x, tmpMMP.y, imgX, imgY) Then
                    
                    'Add these points to the brush engine
                    m_Paintbrush.NotifyBrushXY True, 0, imgX, imgY, tmpMMP.ptTime
                    
                End If
                
            Loop
        
        End If
        
        'Unlike other drawing tools, the paintbrush engine controls viewport redraws.  This allows us to optimize behavior
        ' if we fall behind, and a long queue of drawing actions builds up.
        '
        '(Note that we only request manual redraws if the mouse is currently down; if the mouse *isn't* down, the canvas
        ' handles this for us.)
        Dim tmpPoint As PointFloat, numPointsDrawn As Long
        Do While m_Paintbrush.GetNextPoint(tmpPoint)
            
            'Calculate new modification rects, e.g. the portion of the paintbrush layer affected by this stroke.
            ' (The central compositor requires this information for its optimized paintbrush renderer.)
            UpdateModifiedRect tmpPoint.x, tmpPoint.y, m_Paintbrush.IsFirstDab() And (numPointsDrawn = 0)
            
            'Paint this dab
            ApplyPaintDab tmpPoint.x, tmpPoint.y
                
            'Update the "old" mouse coordinate trackers
            m_MouseX = tmpPoint.x
            m_MouseY = tmpPoint.y
            numPointsDrawn = numPointsDrawn + 1
            
        Loop
        
        'Notify the scratch layer of our updates
        PDImages.GetActiveImage.ScratchLayer.NotifyOfDestructiveChanges
        
        'Report paint tool render times, as relevant
        'Debug.Print "Paint tool render timing: " & Format$(CStr(VBHacks.GetTimerDifferenceNow(startTime) * 1000), "0000.00") & " ms"
    
    'The previous x/y coordinate trackers are updated automatically when the mouse is DOWN.  When the mouse is UP, we must manually
    ' modify those values.
    Else
        m_MouseX = srcX
        m_MouseY = srcY
    End If
    
    'If the shift key is down, we're gonna commit the paint results immediately - so don't waste time
    ' updating the screen, as it's about to be overwritten.
    If mouseButtonDown And (Shift = 0) And m_SourceExists Then UpdateViewportWhilePainting startTime, srcCanvas
    
    'If the mouse button has been released, we can also release our internal GDI+ objects.
    ' (Note that the current *brush* resources are *not* released, by design.)
    If m_Paintbrush.IsLastDab() And m_SourceExists Then
        
        Set m_Surface = Nothing
        
        'Reset the target canvas's mouse handling behavior
        srcCanvas.SetMouseInput_HighRes False
        srcCanvas.SetMouseInput_AutoDrop True
        
    End If
    
End Sub

'While painting, we use a (fairly complicated) set of heuristics to decide when to update the primary viewport.
' We don't want to update it on every paint stroke event, as compositing the full viewport can be a very
' time-consuming process (especially for large images and/or images with many layers).
Private Sub UpdateViewportWhilePainting(ByVal strokeStartTime As Currency, ByRef srcCanvas As pdCanvas)
    
    'Ask the paint engine if now is a good time to update the viewport.
    If m_Paintbrush.IsItTimeForScreenUpdate(strokeStartTime) Or m_Paintbrush.IsFirstDab() Then
    
        'Retrieve viewport parameters, then perform a full layer stack merge and repaint the screen
        Dim tmpViewportParams As PD_ViewportParams
        tmpViewportParams = ViewportEngine.GetDefaultParamObject()
        tmpViewportParams.renderScratchLayerIndex = PDImages.GetActiveImage.GetActiveLayerIndex()
        ViewportEngine.Stage2_CompositeAllLayers PDImages.GetActiveImage(), srcCanvas, VarPtr(tmpViewportParams)
    
    'If not enough time has passed since the last redraw, simply update the cursor
    Else
        ViewportEngine.Stage4_FlipBufferAndDrawUI PDImages.GetActiveImage(), srcCanvas
    End If
    
    'Notify the paint engine that we refreshed the image; it will add this to its running fps tracker
    m_Paintbrush.NotifyScreenUpdated strokeStartTime
    
End Sub

'Apply a single paint dab to the target position.  Note that dab opacity is currently hard-coded at 100%; flow is controlled
' at brush creation time (instead of on-the-fly).  This may change depending on future brush dynamics implementations.
Private Sub ApplyPaintDab(ByVal srcX As Single, ByVal srcY As Single, Optional ByVal dabOpacity As Single = 1!)
    
    Dim allowedToDab As Boolean: allowedToDab = True
    
    'If brush dynamics are active, we only dab the brush if certain criteria are met.  (For example, if enough pixels have
    ' elapsed since the last dab, as controlled by the Brush Spacing parameter.)
    If (m_BrushSpacingCheck > 1) Then allowedToDab = ((m_DistPixels Mod m_BrushSpacingCheck) = 0)
    
    If allowedToDab Then
        
        Dim srcDIB As pdDIB
        If m_SampleMerged Then
            Set srcDIB = m_SampleMergedCopy
        Else
            Set srcDIB = PDImages.GetImageByID(m_SourceImageID).GetLayerByID(m_SourceLayerID).layerDIB
        End If
        
        'Prep the sampling DIB.  Note that it is *always* full size, regardless of the actual brush size we're gonna use
        ' (e.g. the brush may shrink because it's beyond the border of the image, but to reduce memory thrashing, we
        ' always maintain the brush DIB at a fixed size).
        If (m_Sample Is Nothing) Then Set m_Sample = New pdDIB
        If (m_Sample.GetDIBWidth <> m_BrushSizeInt) Or (m_Sample.GetDIBHeight <> m_BrushSizeInt) Then
            m_Sample.CreateBlank m_BrushSizeInt, m_BrushSizeInt, 32, 0, 0
        Else
            m_Sample.ResetDIB 0
        End If
        
        'Next, we need to calculate relevant source and destination rectangles.  GDI's AlphaBlend is incredibly picky
        ' about rectangles that don't lie off the edge of a given image, and we also get a performance boost by only
        ' masking a minimal amount of the brush.
        Dim srcRectL As RectL_WH, dstRectL As RectL_WH
        Dim dstX As Long, dstY As Long
        If CalculateSrcDstRects(Int(srcX + 0.5), Int(srcY + 0.5), dstX, dstY, srcRectL, dstRectL, srcDIB, PDImages.GetActiveImage.ScratchLayer.layerDIB) Then
            
            'Retrieve the relevant portion of the source image, then make an *untouched* copy of it
            m_Sample.SetInitialAlphaPremultiplicationState True
            GDI.BitBltWrapper m_Sample.GetDIBDC, dstRectL.Left, dstRectL.Top, dstRectL.Width, dstRectL.Height, srcDIB.GetDIBDC, srcRectL.Left, srcRectL.Top
            Set srcDIB = Nothing
            
            If (m_SampleUntouched Is Nothing) Then Set m_SampleUntouched = New pdDIB
            m_SampleUntouched.CreateFromExistingDIB m_Sample
            
            'Mask the outline of the current brush over the source image.
            Dim pxMask() As Byte, pxSample() As Byte, pxDst() As Byte
            Dim maskSA As SafeArray1D, sampleSA As SafeArray1D, dstSA As SafeArray1D
            
            Dim x As Long, y As Long, xStride As Long, tmpFloat As Single
            Dim fLookup() As Single
            ReDim fLookup(0 To 255) As Single
            
            For x = 0 To 255
                fLookup(x) = CSng(x) / 255!
            Next x
            
            Dim xStart As Long, xEnd As Long, yStart As Long, yEnd As Long
            xStart = dstRectL.Left
            xEnd = dstRectL.Left + dstRectL.Width - 1
            yStart = dstRectL.Top
            yEnd = dstRectL.Top + dstRectL.Height - 1
            
            For y = yStart To yEnd
                m_Sample.WrapArrayAroundScanline pxSample, sampleSA, y
            For x = xStart To xEnd
                xStride = x * 4
                tmpFloat = fLookup(m_Mask(x, y))
                pxSample(xStride) = pxSample(xStride) * tmpFloat
                pxSample(xStride + 1) = pxSample(xStride + 1) * tmpFloat
                pxSample(xStride + 2) = pxSample(xStride + 2) * tmpFloat
                pxSample(xStride + 3) = pxSample(xStride + 3) * tmpFloat
            Next x
            Next y
            
            m_Sample.UnwrapArrayFromDIB pxSample
            
            'Apply the dab
            Dim dstDIB As pdDIB
            Set dstDIB = PDImages.GetActiveImage.ScratchLayer.layerDIB
            m_Sample.AlphaBlendToDCEx dstDIB.GetDIBDC, dstX, dstY, dstRectL.Width, dstRectL.Height, dstRectL.Left, dstRectL.Top, dstRectL.Width, dstRectL.Height, dabOpacity * 255
            
            'We now need to do something special for semi-transparent pixels.  These pixels *cannot* be allowed
            ' to become more transparent than the source pixel data (otherwise it wouldn't be a clone operation).
            ' As such, we need to scan the pixels we just painted, and ensure that they do not exceed their
            ' original transparency values.
            
            'Why not just perform the alpha-blend ourselves and do this as we go?  Because for fully opaque clones
            ' (e.g. photos!), a GDI AlphaBlend is hardware-accelerated - much faster than we can possibly blend -
            ' while this secondary step is extremely fast as the CPU can branch-predict it with 100% accuracy.
            ' So nearly no time is lost compared to a regular alpha blend op for the most common use-case.
            
            'Normally we would need to do some messy boundary checks here, but this was already handled by the
            ' CalculateSrcDstRects() function, above.
            Dim pxSampleL() As RGBQuad, pxDstL() As RGBQuad
            Dim refAlpha As Long, testAlpha As Long
            
            Dim xOffset As Long, yOffset As Long
            xOffset = (dstX - dstRectL.Left)
            yOffset = dstY - dstRectL.Top
            
            xStart = dstRectL.Left
            xEnd = (dstRectL.Left + dstRectL.Width - 1)
            yStart = dstRectL.Top
            yEnd = dstRectL.Top + dstRectL.Height - 1
            
            For y = yStart To yEnd
                m_SampleUntouched.WrapRGBQuadArrayAroundScanline pxSampleL, sampleSA, y
                dstDIB.WrapRGBQuadArrayAroundScanline pxDstL, dstSA, yOffset + y
            For x = xStart To xEnd
                
                'Retrieve our "reference" alpha values from the sample
                refAlpha = pxSampleL(x).Alpha
                
                'Ignore opaque pixels
                If (refAlpha < 255) Then
                
                    'Is the destination alpha higher than the original source's alpha?
                    ' If it is, clone the destination pixel in its place.
                    testAlpha = pxDstL(xOffset + x).Alpha
                    If (testAlpha > refAlpha) Then pxDstL(xOffset + x) = pxSampleL(x)
                    
                End If
            
            Next x
            Next y
            
            'Free array references
            m_SampleUntouched.UnwrapRGBQuadArrayFromDIB pxSampleL
            dstDIB.UnwrapRGBQuadArrayFromDIB pxDstL
            
        '/end clone regions are valid
        End If
        
    End If
    
    'Each time we make a new dab, we keep a running tally of how many pixels we've traversed.  Some brush dynamics (e.g. spacing)
    ' rely on this value for correct rendering behavior.
    m_DistPixels = m_DistPixels + 1
    
End Sub

'Determine source+dest blends for the current clone region.  Returns TRUE if the region is non-zero; FALSE otherwise.
' (Do *NOT* waste time rendering a dab if the return value is FALSE.)
Private Function CalculateSrcDstRects(ByVal srcX As Long, ByVal srcY As Long, ByRef dstX As Long, ByRef dstY As Long, ByRef srcRectL As RectL_WH, ByRef dstRectL As RectL_WH, ByRef srcDIB As pdDIB, ByRef scratchLayerDIB As pdDIB) As Boolean

    'Start by populating both rects with default values
    With srcRectL
        .Left = Int(srcX - m_BrushSizeInt \ 2 + m_SourceOffsetX)
        .Top = Int(srcY - m_BrushSizeInt \ 2 + m_SourceOffsetY)
        .Width = m_BrushSizeInt
        .Height = m_BrushSizeInt
    End With
    
    With dstRectL
        .Left = 0
        .Top = 0
        'dstRectL width and height will *always* be identical to srcRectL width and height; as such,
        ' we don't populate them until the end of this function
    End With
    
    'Next, perform boundary checks on the source rectangle, and modify *both* rectangles to account for any changes
    Dim tmpOffset As Long
    If (srcRectL.Left < 0) Then
        tmpOffset = srcRectL.Left
        srcRectL.Left = 0
        dstRectL.Left = dstRectL.Left - tmpOffset
        srcRectL.Width = srcRectL.Width + tmpOffset
    End If
    
    If (srcRectL.Top < 0) Then
        tmpOffset = srcRectL.Top
        srcRectL.Top = 0
        dstRectL.Top = dstRectL.Top - tmpOffset
        srcRectL.Height = srcRectL.Height + tmpOffset
    End If
    
    If (srcRectL.Left + srcRectL.Width > srcDIB.GetDIBWidth) Then
        tmpOffset = (srcRectL.Left + srcRectL.Width) - srcDIB.GetDIBWidth
        srcRectL.Width = srcRectL.Width - tmpOffset
    End If
    
    If (srcRectL.Top + srcRectL.Height > srcDIB.GetDIBHeight) Then
        tmpOffset = (srcRectL.Top + srcRectL.Height) - srcDIB.GetDIBHeight
        srcRectL.Height = srcRectL.Height - tmpOffset
    End If
    
    'As a convenience, let's also calculate out-of-bounds destination pixels (which use scratch layer boundaries)
    
    'Determine where an "ideal" dab will be placed
    dstX = Int(srcX - m_BrushSize \ 2) + dstRectL.Left
    dstY = Int(srcY - m_BrushSize \ 2) + dstRectL.Top
        
    If (dstX < 0) Then
        tmpOffset = dstX
        dstX = 0
        dstRectL.Left = dstRectL.Left - tmpOffset
        srcRectL.Left = srcRectL.Left - tmpOffset
        srcRectL.Width = srcRectL.Width + tmpOffset
    End If
    
    If (dstY < 0) Then
        tmpOffset = dstY
        dstY = 0
        dstRectL.Top = dstRectL.Top - tmpOffset
        srcRectL.Top = srcRectL.Top - tmpOffset
        srcRectL.Height = srcRectL.Height + tmpOffset
    End If
    
    If (dstX + srcRectL.Width > scratchLayerDIB.GetDIBWidth) Then
        tmpOffset = (dstX + srcRectL.Width) - scratchLayerDIB.GetDIBWidth
        srcRectL.Width = srcRectL.Width - tmpOffset
    End If
    
    If (dstY + srcRectL.Height > scratchLayerDIB.GetDIBHeight) Then
        tmpOffset = (dstY + srcRectL.Height) - scratchLayerDIB.GetDIBHeight
        srcRectL.Height = srcRectL.Height - tmpOffset
    End If
    
    'Mirror the source width/height to the destination
    dstRectL.Width = srcRectL.Width
    dstRectL.Height = srcRectL.Height
    
    'Rects with sub-zero (or zero) dimensions are invalid, and we can skip painting them entirely
    CalculateSrcDstRects = (srcRectL.Width > 0) And (srcRectL.Height > 0)
    
End Function

'Whenever we receive notifications of a new mouse (x, y) pair, you need to call this sub to calculate a new "affected area" rect.
' The compositor uses this "affected area" rect to minimize the amount of rendering work it needs to perform.
Private Sub UpdateModifiedRect(ByVal newX As Single, ByVal newY As Single, ByVal isFirstStroke As Boolean)

    'Start by calculating the affected rect for just this stroke.
    Dim tmpRectF As RectF
    If (newX < m_MouseX) Then
        tmpRectF.Left = newX
        tmpRectF.Width = m_MouseX - newX
    Else
        tmpRectF.Left = m_MouseX
        tmpRectF.Width = newX - m_MouseX
    End If
    
    If (newY < m_MouseY) Then
        tmpRectF.Top = newY
        tmpRectF.Height = m_MouseY - newY
    Else
        tmpRectF.Top = m_MouseY
        tmpRectF.Height = newY - m_MouseY
    End If
    
    'Inflate the rect calculation by the size of the current brush, while accounting for the possibility of antialiasing
    ' (which may extend up to 1.0 pixel outside the calculated boundary area).
    Dim halfBrushSize As Single
    halfBrushSize = m_BrushSize / 2 + 1#
    
    tmpRectF.Left = tmpRectF.Left - halfBrushSize
    tmpRectF.Top = tmpRectF.Top - halfBrushSize
    
    halfBrushSize = halfBrushSize * 2
    tmpRectF.Width = tmpRectF.Width + halfBrushSize
    tmpRectF.Height = tmpRectF.Height + halfBrushSize
    
    Dim tmpOldRectF As RectF
    
    'Normally, we union the current rect against our previous (running) modified rect.
    ' Two circumstances prevent this, however:
    ' 1) This is the first dab in a stroke (so there is no running modification rect)
    ' 2) The compositor just retrieved our running modification rect, and updated the screen accordingly.
    '    This means we can start a new rect instead.
    'If this is *not* the first modified rect calculation, union this rect with our previous update rect
    If m_UnionRectRequired And (Not isFirstStroke) Then
        tmpOldRectF = m_ModifiedRectF
        PDMath.UnionRectF m_ModifiedRectF, tmpRectF, tmpOldRectF
    Else
        m_UnionRectRequired = True
        m_ModifiedRectF = tmpRectF
    End If
    
    'Always calculate a running "total combined RectF", for use in the final merge step
    If isFirstStroke Then
        m_TotalModifiedRectF = tmpRectF
    Else
        tmpOldRectF = m_TotalModifiedRectF
        PDMath.UnionRectF m_TotalModifiedRectF, tmpRectF, tmpOldRectF
    End If
    
End Sub

'If the source image+layer combination doesn't exist, this sub will reset m_SourceExists to FALSE
Private Sub EnsureSourceExists()

    If m_SourceExists Then
    
        If (Not PDImages.IsImageActive(m_SourceImageID)) Then m_SourceExists = False
        If m_SourceExists And (Not m_SampleMerged) Then
            If (PDImages.GetImageByID(m_SourceImageID).GetLayerByID(m_SourceLayerID) Is Nothing) Then m_SourceExists = False
        End If
    
    End If

End Sub

'When the active image changes, we need to reset certain brush-related parameters
Public Sub NotifyActiveImageChanged()
    
    m_Paintbrush.Reset
    
    m_MouseX = MOUSE_OOB
    m_MouseY = MOUSE_OOB
    
    'Make sure our source point hasn't disappeared (e.g. been unloaded)
    EnsureSourceExists
    
End Sub

'Return the area of the image modified by the current stroke.
' IMPORTANTLY: the running modified rect is FORCIBLY RESET after a call to this function, by design.
' (After PD's compositor retrieves the modification rect, everything inside that rect will get updated -
'  so we can start our next batch of modifications afresh.)
Public Function GetModifiedUpdateRectF() As RectF
    GetModifiedUpdateRectF = m_ModifiedRectF
    m_UnionRectRequired = False
End Function

Public Function IsFirstDab() As Boolean
    If (m_Paintbrush Is Nothing) Then IsFirstDab = False Else IsFirstDab = m_Paintbrush.IsFirstDab()
End Function

'Want to commit your current brush work?  Call this function to make the brush results permanent.
Public Sub CommitBrushResults()
    
    'Check ctrl key status and skip this step accordingly
    If m_SourceSetThisClick Then Exit Sub
    
    'This dummy string only exists to ensure that the processor name gets localized properly
    ' (as that text is used for Undo/Redo descriptions).  PD's translation engine will detect
    ' the TranslateMessage() call and produce a matching translation entry.
    Dim strDummy As String
    strDummy = g_Language.TranslateMessage("Clone stamp")
    Layers.CommitScratchLayer "Clone stamp", m_TotalModifiedRectF
    
End Sub

'Render the current brush outline to the canvas, using the stored mouse coordinates as the brush's position
Public Sub RenderBrushOutline(ByRef targetCanvas As pdCanvas)
    
    'If a brush outline doesn't exist, create one now
    If (Not m_BrushIsReady) Then CreateCurrentBrush True
    
    'Ensure the source point (if any) exists
    EnsureSourceExists
    
    'If the on-screen brush size is above a certain threshold, we'll paint a full brush outline.
    ' If it's too small, we'll only paint a cross in the current brush position.
    Dim onScreenSize As Double
    onScreenSize = Drawing.ConvertImageSizeToCanvasSize(m_BrushSize, PDImages.GetActiveImage())
    
    Dim brushTooSmall As Boolean
    brushTooSmall = (onScreenSize < 7#)
    
    'Borrow a pair of UI pens from the main rendering module
    Dim innerPen As pd2DPen, outerPen As pd2DPen
    Drawing.BorrowCachedUIPens outerPen, innerPen
    
    'Create other required pd2D drawing tools (a surface)
    Dim cSurface As pd2DSurface
    Drawing2D.QuickCreateSurfaceFromDC cSurface, targetCanvas.hDC, True
    
    'Other misc drawing tools
    Dim canvasMatrix As pd2DTransform
    Dim srcX As Double, srcY As Double
    Dim cursX As Double, cursY As Double
    Dim oldX As Double, oldY As Double
    Dim lastPoint As PointFloat
    Dim crossLength As Single, outerCrossBorder As Single
    Dim copyOfBrushOutline As pd2DPath
    Dim backupWidth As Single, dashSizes() As Single
    Dim okToProceed As Boolean
    
    'If the user is currently holding down the ctrl key, they're trying to set a source point.
    ' Render a special outline just for this occasion.
    If m_CtrlKeyDown Then
        
        srcX = m_MouseX
        srcY = m_MouseY
        
        'Same steps as normal rendering; skip down to see detailed comments on what these lines do
        Set canvasMatrix = Nothing
        Drawing.GetTransformFromImageToCanvas canvasMatrix, targetCanvas, PDImages.GetActiveImage(), srcX, srcY
        Drawing.ConvertImageCoordsToCanvasCoords targetCanvas, PDImages.GetActiveImage(), srcX, srcY, cursX, cursY
        
        'Paint a target cursor - but *only* if the mouse is not currently down!
        crossLength = 3#
        outerCrossBorder = 0.5
        
        outerPen.SetPenLineCap P2_LC_Round
        innerPen.SetPenLineCap P2_LC_Round
        PD2D.DrawLineF cSurface, outerPen, cursX, cursY - crossLength - outerCrossBorder, cursX, cursY + crossLength + outerCrossBorder
        PD2D.DrawLineF cSurface, outerPen, cursX - crossLength - outerCrossBorder, cursY, cursX + crossLength + outerCrossBorder, cursY
        PD2D.DrawLineF cSurface, innerPen, cursX, cursY - crossLength, cursX, cursY + crossLength
        PD2D.DrawLineF cSurface, innerPen, cursX - crossLength, cursY, cursX + crossLength, cursY
    
        'If size allows, render a transformed brush outline onto the canvas as well
        If (Not brushTooSmall) Then
            
            'Get a copy of the current brush outline, transformed into position
            Set copyOfBrushOutline = New pd2DPath
            copyOfBrushOutline.CloneExistingPath m_BrushOutlinePath
            copyOfBrushOutline.ApplyTransformation canvasMatrix
    
            backupWidth = outerPen.GetPenWidth
            outerPen.SetPenWidth 1.6
            
            innerPen.SetPenStyle P2_DS_Custom
            innerPen.SetPenDashCap P2_DC_Round
            
            ReDim dashSizes(0 To 1) As Single
            dashSizes(0) = 2.5!
            dashSizes(1) = 2.5!
            innerPen.SetPenDashes_UNSAFE VarPtr(dashSizes(0)), 2
            
            PD2D.DrawPath cSurface, outerPen, copyOfBrushOutline
            PD2D.DrawPath cSurface, innerPen, copyOfBrushOutline
            
            innerPen.SetPenStyle P2_DS_Solid
            outerPen.SetPenWidth backupWidth
            
        End If
        
    'If the ctrl key is *not* down, rendering is more complicated, as it depends on a bunch of
    ' factors (is a source point set? is a paint stroke active? is shift being used? etc)
    Else
        
        'We now want to (potentially) draw *two* sets of brush outlines - one for the brush location,
        ' and a second one for the source location, if it exists.  We also want the cursor for the
        ' brush position (i = 0) to "overlay" the indicator for the source position (i = 1), which is
        ' why we draw the points in reverse
        Dim i As Long
        For i = 1 To 0 Step -1
        
            'Skip all steps for the source point if it doesn't exist
            If (i = 1) And (Not m_SourceExists) Then GoTo DrawNextPoint
            If (i = 1) And (m_SourceImageID <> PDImages.GetActiveImageID) Then GoTo DrawNextPoint
            
            'Set the relevant source point (i = 0, use cursor position; i = 1, use source point)
            If (i = 0) Then
                srcX = m_MouseX
                srcY = m_MouseY
            Else
                If m_Paintbrush.IsMouseDown() Then
                    srcX = m_MouseX + m_SourceOffsetX
                    srcY = m_MouseY + m_SourceOffsetY
                Else
                    srcX = m_SourcePoint.x
                    srcY = m_SourcePoint.y
                End If
            End If
            
            'Start by creating a transformation from the image space to the canvas space
            Set canvasMatrix = Nothing
            Drawing.GetTransformFromImageToCanvas canvasMatrix, targetCanvas, PDImages.GetActiveImage(), srcX, srcY
            
            'We also want to pinpoint the precise cursor position
            Drawing.ConvertImageCoordsToCanvasCoords targetCanvas, PDImages.GetActiveImage(), srcX, srcY, cursX, cursY
            
            'If the user is holding down the SHIFT key, paint a line between the end of the previous stroke and the current
            ' mouse position.  This helps communicate that shift+clicking will string together separate strokes.
            If (i = 0) Then okToProceed = m_ShiftKeyDown And m_Paintbrush.GetLastAddedPoint(lastPoint)
            If okToProceed Then
                
                outerPen.SetPenLineCap P2_LC_Round
                innerPen.SetPenLineCap P2_LC_Round
                
                If (i = 0) Then
                    Drawing.ConvertImageCoordsToCanvasCoords targetCanvas, PDImages.GetActiveImage(), lastPoint.x, lastPoint.y, oldX, oldY
                    PD2D.DrawLineF cSurface, outerPen, oldX, oldY, cursX, cursY
                    PD2D.DrawLineF cSurface, innerPen, oldX, oldY, cursX, cursY
                Else
                    lastPoint.x = m_SourcePoint.x + (m_MouseX - lastPoint.x)
                    lastPoint.y = m_SourcePoint.y + (m_MouseY - lastPoint.y)
                    Drawing.ConvertImageCoordsToCanvasCoords targetCanvas, PDImages.GetActiveImage(), lastPoint.x, lastPoint.y, oldX, oldY
                    PD2D.DrawLineF cSurface, outerPen, oldX, oldY, cursX, cursY
                    PD2D.DrawLineF cSurface, innerPen, oldX, oldY, cursX, cursY
                End If
                
            Else
                
                'Paint a target cursor - but *only* if the mouse is not currently down!
                crossLength = 3#
                outerCrossBorder = 0.5
                
                If (Not m_Paintbrush.IsMouseDown()) And (i = 0) Then
                    outerPen.SetPenLineCap P2_LC_Round
                    innerPen.SetPenLineCap P2_LC_Round
                    PD2D.DrawLineF cSurface, outerPen, cursX, cursY - crossLength - outerCrossBorder, cursX, cursY + crossLength + outerCrossBorder
                    PD2D.DrawLineF cSurface, outerPen, cursX - crossLength - outerCrossBorder, cursY, cursX + crossLength + outerCrossBorder, cursY
                    PD2D.DrawLineF cSurface, innerPen, cursX, cursY - crossLength, cursX, cursY + crossLength
                    PD2D.DrawLineF cSurface, innerPen, cursX - crossLength, cursY, cursX + crossLength, cursY
                End If
                
            End If
            
            'If size allows, render a transformed brush outline onto the canvas as well
            If (Not brushTooSmall) Then
                
                'Get a copy of the current brush outline, transformed into position
                Set copyOfBrushOutline = New pd2DPath
                copyOfBrushOutline.CloneExistingPath m_BrushOutlinePath
                copyOfBrushOutline.ApplyTransformation canvasMatrix
                
                If (i = 1) Then
                    
                    backupWidth = outerPen.GetPenWidth
                    outerPen.SetPenWidth 1.6
                    
                    innerPen.SetPenStyle P2_DS_Custom
                    innerPen.SetPenDashCap P2_DC_Round
                    
                    ReDim dashSizes(0 To 1) As Single
                    dashSizes(0) = 2.5!
                    dashSizes(1) = 2.5!
                    innerPen.SetPenDashes_UNSAFE VarPtr(dashSizes(0)), 2
                    
                    PD2D.DrawPath cSurface, outerPen, copyOfBrushOutline
                    PD2D.DrawPath cSurface, innerPen, copyOfBrushOutline
                    
                    innerPen.SetPenStyle P2_DS_Solid
                    outerPen.SetPenWidth backupWidth
                    
                Else
                    PD2D.DrawPath cSurface, outerPen, copyOfBrushOutline
                    PD2D.DrawPath cSurface, innerPen, copyOfBrushOutline
                End If
                
            End If
    
DrawNextPoint:
        Next i
        
    End If
    
    Set cSurface = Nothing
    
End Sub

'Any specialized initialization tasks can be handled here.  This function is called early in the PD load process.
Public Sub InitializeBrushEngine()
    
    'Initialize the underlying brush class
    Set m_Paintbrush = New pdPaintbrush
    
    'Reset UI-centric features
    m_BrushAntialiasing = P2_AA_HighQuality
    
    'Reset all coordinates
    m_MouseX = MOUSE_OOB
    m_MouseY = MOUSE_OOB
    
    'Note that the current brush has *not* been created yet!
    m_BrushIsReady = False
    m_BrushCreatedAtLeastOnce = False
    
    'Flow and spacing are *not* currently available to the user (in the tool UI).  They may be restored
    ' in a future update, and as such, no work is required to integrate them - the values are "ready to go".
    ' For now, we just set them to default values.
    m_BrushSpacing = 0#
    m_BrushFlow = 100#
    
End Sub

'Want to free up memory without completely releasing everything tied to this class?  That's what this function
' is for.  It should (ideally) be called whenever this tool is deactivated.
'
'Importantly, this sub does *not* touch anything that may require the underlying tool engine to be re-initialized.
' It only releases objects that the tool will auto-generate as necessary.
Public Sub ReduceMemoryIfPossible()
    
    Set m_BrushOutlinePath = Nothing
    
    'When freeing the underlying brush, we also need to reset its creation flags
    ' (to ensure it gets re-created correctly)
    m_BrushIsReady = False
    m_BrushCreatedAtLeastOnce = False
    Set m_SrcPenDIB = Nothing
    
    m_MaskSize = 0
    Erase m_Mask
    
    Set m_SampleMergedCopy = Nothing
    Set m_Sample = Nothing
    Set m_SampleUntouched = Nothing
    
    'While we're here, remove the source point
    m_SourceExists = False
    
End Sub

'Before PD closes, you *must* call this function!  It will free any lingering brush resources (which are cached
' for performance reasons).
Public Sub FreeBrushResources()
    ReduceMemoryIfPossible
End Sub