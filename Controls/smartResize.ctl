VERSION 5.00
Begin VB.UserControl smartResize 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   ClientHeight    =   2505
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6810
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ScaleHeight     =   167
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   454
   ToolboxBitmap   =   "smartResize.ctx":0000
   Begin PhotoDemon.jcbutton cmdAspectRatio 
      Height          =   630
      Left            =   420
      TabIndex        =   10
      Top             =   180
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   1111
      ButtonStyle     =   7
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BackColor       =   -2147483643
      Caption         =   ""
      Mode            =   1
      Value           =   -1  'True
      PictureNormal   =   "smartResize.ctx":0312
      PictureDown     =   "smartResize.ctx":1764
      PictureEffectOnDown=   0
      CaptionEffects  =   0
      ColorScheme     =   3
   End
   Begin VB.ComboBox cmbHeightUnit 
      Height          =   360
      Left            =   3600
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   600
      Width           =   3015
   End
   Begin VB.ComboBox cmbWidthUnit 
      Height          =   360
      Left            =   3600
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   0
      Width           =   3015
   End
   Begin PhotoDemon.textUpDown tudWidth 
      Height          =   405
      Left            =   2280
      TabIndex        =   0
      Top             =   0
      Width           =   1200
      _ExtentX        =   2117
      _ExtentY        =   714
      Min             =   1
      Max             =   32767
      Value           =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin PhotoDemon.textUpDown tudHeight 
      Height          =   405
      Left            =   2280
      TabIndex        =   1
      Top             =   600
      Width           =   1200
      _ExtentX        =   2117
      _ExtentY        =   714
      Min             =   1
      Max             =   32767
      Value           =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblDimensions 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "dimensions:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Index           =   0
      Left            =   915
      TabIndex        =   5
      Top             =   1230
      Width           =   1290
   End
   Begin VB.Label lblDimensions 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "            "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Index           =   1
      Left            =   2280
      TabIndex        =   9
      Top             =   1230
      Width           =   900
   End
   Begin VB.Label lblAspectRatio 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "            "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Index           =   1
      Left            =   2280
      TabIndex        =   8
      Top             =   1800
      Width           =   900
   End
   Begin VB.Label lblWidth 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "width:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Left            =   1530
      TabIndex        =   4
      Top             =   45
      Width           =   675
   End
   Begin VB.Label lblHeight 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "height:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Left            =   1455
      TabIndex        =   3
      Top             =   645
      Width           =   750
   End
   Begin VB.Label lblAspectRatio 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "aspect ratio:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   285
      Index           =   0
      Left            =   900
      TabIndex        =   2
      Top             =   1800
      Width           =   1305
   End
End
Attribute VB_Name = "smartResize"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'***************************************************************************
'Image Resize User Control
'Copyright �2001-2014 by Tanner Helland
'Created: 6/12/01 (original resize dialog), 24/Jan/14 (conversion to user control)
'Last updated: 31/Jan/14
'Last update: wrap up initial conversion of resize UI to dedicated user control
'
'Many tools in PD relate to resizing: image size, canvas size, (soon) layer size, content-aware rescaling,
' perhaps a more advanced autocrop tool, plus dedicated resize options in the batch converter...
'
'Rather than develop custom resize UIs for all these scenarios, I finally asked myself: why not use a single
' resize-centric user control? As an added bonus, that would allow me to update the user control to extend new
' capabilities to all of PD's resize tools.
'
'Thus this UC was born.  All resize-related dialogs in the project now use it, and any added features can now
' automatically propagate across them.
'
'All source code in this file is licensed under a modified BSD license.  This means you may use the code in your own
' projects IF you provide attribution.  For more information, please visit http://photodemon.org/about/license/
'
'***************************************************************************

Option Explicit

'This object provides a single raised event:
' - Change (which triggers when a size value is updated)
Public Event Change(newWidthPixels As Double, newHeightPixels As Double, ByVal curWidthText As String, ByVal curHeightText As String)

Private WithEvents mFont As StdFont
Attribute mFont.VB_VarHelpID = -1

'Store a copy of the original width/height values we are passed
Private initWidth As Long, initHeight As Long

'Store a copy of the initial DPI value we are passed
Private initDPI As Double

'Used for maintaining ratios when the check box is clicked
Private wRatio As Double, hRatio As Double

'Used to prevent infinite recursion as updates to one text box force updates to the other
Private allowedToUpdateWidth As Boolean, allowedToUpdateHeight As Boolean

'Used to prevent infinite recursion as updates to one pixel init dropdown forces updates to the other
Private unitSyncingSuspended As Boolean

'When switching from one type of measurement to another, we must convert measurement values accordingly.
' This function is used to store the previous measurement method, which helps the conversion function know how to switch values.
Private previousUnitOfMeasurement As MeasurementUnit

'Custom tooltip class allows for things like multiline, theming, and multiple monitor support
Dim m_ToolTip As clsToolTip

'If any text value is NOT valid, this will return FALSE
Public Property Get IsValid(Optional ByVal showError As Boolean = True) As Boolean
    
    IsValid = True
    
    'If the current text value is not valid, highlight the problem and optionally display an error message box
    If Not tudWidth.IsValid(showError) Then
        IsValid = False
        Exit Function
    End If
    
    If Not tudHeight.IsValid(showError) Then
        IsValid = False
        Exit Function
    End If
    
End Property

'Font handling is a bit specialized for user controls; see http://msdn.microsoft.com/en-us/library/aa261313%28v=vs.60%29.aspx
Public Property Get Font() As StdFont
    Set Font = mFont
End Property

Public Property Set Font(mNewFont As StdFont)
    With mFont
        .Bold = mNewFont.Bold
        .Italic = mNewFont.Italic
        .Name = mNewFont.Name
        .Size = mNewFont.Size
    End With
    PropertyChanged "Font"
End Property

'When the control's font is changed, this sub will be fired; make sure all child controls have their fonts changed here.
Private Sub mFont_FontChanged(ByVal PropertyName As String)
    Set UserControl.Font = mFont
    Set lblWidth.Font = UserControl.Font
    Set lblHeight.Font = UserControl.Font
    Set lblAspectRatio(0).Font = UserControl.Font
    Set lblAspectRatio(1).Font = UserControl.Font
    Set lblDimensions(0).Font = UserControl.Font
    Set lblDimensions(1).Font = UserControl.Font
    Set tudWidth.Font = UserControl.Font
    Set tudHeight.Font = UserControl.Font
    Set cmbWidthUnit.Font = UserControl.Font
    Set cmbHeightUnit.Font = UserControl.Font
End Sub

'jcButton requires an hWnd for the parent control for subclassing purposes
Public Property Get hWnd() As Long
    hWnd = UserControl.hWnd
End Property

'Lock aspect ratio can be set/retrieved by the owning dialog
Public Property Get lockAspectRatio() As Boolean
    lockAspectRatio = cmdAspectRatio.Value
End Property

Public Property Let lockAspectRatio(newSetting As Boolean)
    cmdAspectRatio.Value = newSetting
    syncDimensions True
End Property

'Width and height can be set/retrieved from these properties
Public Property Get imgWidth() As Long
    imgWidth = getImageWidthInPixels(cmbWidthUnit.ListIndex)
End Property

Public Property Let imgWidth(newWidth As Long)
    tudWidth = newWidth
    syncDimensions True
End Property

Public Property Get imgHeight() As Long
    imgHeight = getImageHeightInPixels(cmbHeightUnit.ListIndex)
End Property

Public Property Let imgHeight(newHeight As Long)
    tudHeight = newHeight
    syncDimensions False
End Property

'The current unit of measurement can also be retrieved.  Note that these values are kept in sync for both width/height.
Public Property Get UnitOfMeasurement() As MeasurementUnit
    UnitOfMeasurement = cmbWidthUnit.ListIndex
End Property

Public Property Let UnitOfMeasurement(newUnit As MeasurementUnit)
    cmbWidthUnit.ListIndex = newUnit
End Property

Private Sub cmbHeightUnit_Click()

    If unitSyncingSuspended Then Exit Sub
    
    'Suspend automatic synchronzation
    unitSyncingSuspended = True
    
    'Make the width drop-down match this one
    cmbWidthUnit.ListIndex = cmbHeightUnit.ListIndex
    
    'Convert the current measurements to the new ones.
    convertUnitsToNewValue previousUnitOfMeasurement, cmbHeightUnit.ListIndex
    
    'Mark this as the previous unit of measurement.  Future unit conversions will rely on this value to know how to convert the present values.
    previousUnitOfMeasurement = cmbHeightUnit.ListIndex
    
    'Restore automatic synchronization
    unitSyncingSuspended = False
    
    'Perform a final synchronization
    syncDimensions False

End Sub

Private Sub cmbWidthUnit_Click()
    
    If unitSyncingSuspended Then Exit Sub

    'Suspend automatic synchronzation
    unitSyncingSuspended = True
    
    'Make the height drop-down match this one
    cmbHeightUnit.ListIndex = cmbWidthUnit.ListIndex
    
    'Convert the current measurements to the new ones.
    convertUnitsToNewValue previousUnitOfMeasurement, cmbWidthUnit.ListIndex
    
    'Mark this as the previous unit of measurement.  Future unit conversions will rely on this value to know how to convert the present values.
    previousUnitOfMeasurement = cmbWidthUnit.ListIndex
    
    'Restore automatic synchronization
    unitSyncingSuspended = False
    
    'Perform a final synchronization
    syncDimensions True

End Sub

'Whenever the user switches to a new unit of measurement, we must convert all text box values (and possible limits and/or
' significant digits) to match.  Use this function to do so.
Private Sub convertUnitsToNewValue(ByVal oldUnit As MeasurementUnit, ByVal newUnit As MeasurementUnit)

    'Start by retrieving the old values in pixel measurements
    Dim imgWidthPixels As Double, imgHeightPixels As Double
    imgWidthPixels = getImageWidthInPixels(oldUnit)
    imgHeightPixels = getImageHeightInPixels(oldUnit)
    
    'Use those pixel measurements to retrieve new values in the desired unit of measurement
    Dim newWidth As Double, newHeight As Double
    newWidth = getCustomWidthValue(newUnit, imgWidthPixels)
    newHeight = getCustomHeightValue(newUnit, imgHeightPixels)
    
    'Copy the new values to their respective text boxes
    tudWidth = newWidth
    tudHeight = newHeight
    
End Sub

Private Sub cmdAspectRatio_Click()
    syncDimensions True
End Sub

'Before using this control, dialogs MUST call this function to notify the control of the initial width/height values
' they want to use.  We cannot do this automatically as some dialogs determine this by the current image's dimensions
' (e.g. resize) while others may do it when no images are loaded (e.g. batch process).
Public Sub setInitialDimensions(ByVal srcWidth As Long, ByVal srcHeight As Long, Optional ByVal srcDPI As Double = 92)

    'Store local copies
    initWidth = srcWidth
    initHeight = srcHeight
    
    initDPI = srcDPI
    
    'To prevent aspect ratio changes to one box resulting in recursion-type changes to the other, we only
    ' allow one box at a time to be updated.
    allowedToUpdateWidth = True
    allowedToUpdateHeight = True
    
    'Establish aspect ratios
    wRatio = initWidth / initHeight
    hRatio = initHeight / initWidth
    
    'Display the initial width/height
    tudWidth = srcWidth
    tudHeight = srcHeight
    
    'Set the "previous unit of measurement" to equal pixels, as that's always how we begin
    previousUnitOfMeasurement = MU_PIXELS

End Sub

Private Sub UserControl_Initialize()
    
    'When compiled, manifest-themed controls need to be further subclassed so they can have transparent backgrounds.
    If g_IsProgramCompiled And g_IsThemingEnabled And g_IsVistaOrLater Then
        g_Themer.requestContainerSubclass UserControl.hWnd
    End If
    
    allowedToUpdateWidth = True
    allowedToUpdateHeight = True
    
    'Prevent unit syncing until the combo boxes have been populated
    unitSyncingSuspended = True
    
    'Populate the width unit drop-down box
    cmbWidthUnit.Clear
    
    cmbWidthUnit.AddItem " percent", 0
    cmbWidthUnit.AddItem " pixels", 1
    cmbWidthUnit.ListIndex = MU_PIXELS
    
    'Rather than manually populate the height unit box, just copy whatever entries we've set for the width box
    cmbHeightUnit.Clear
    
    Dim i As Long
    For i = 0 To cmbWidthUnit.ListCount - 1
        cmbHeightUnit.AddItem cmbWidthUnit.List(i), i
    Next i
    
    cmbHeightUnit.ListIndex = cmbWidthUnit.ListIndex
    
    'Restore automatic unit syncing
    unitSyncingSuspended = False
    
    'Prepare a font object for use
    Set mFont = New StdFont
    Set UserControl.Font = mFont

End Sub

Private Sub UserControl_InitProperties()

    Set mFont = UserControl.Font
    mFont.Name = "Tahoma"
    mFont.Size = 10
    mFont_FontChanged ("")

End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    With PropBag
        Set Font = .ReadProperty("Font", Ambient.Font)
    End With
    
End Sub

Private Sub UserControl_Show()

    'Translate various bits of UI text at run-time
    If g_UserModeFix Then
        
        lblWidth.Caption = g_Language.TranslateMessage("width") & ":"
        lblHeight.Caption = g_Language.TranslateMessage("height") & ":"
        lblWidth.Refresh
        lblHeight.Refresh
        
        lblDimensions(0).Caption = g_Language.TranslateMessage("dimensions") & ":"
        lblAspectRatio(0).Caption = g_Language.TranslateMessage("aspect ratio") & ":"
        
        'UPDATE 09 February 14
        'I'm trying a new strategy for auto-alignment, per http://helpx.adobe.com/photoshop/using/resizing-image.html
        ' Photoshop has a lovely layout for their latest resize dialog, using much better alignment than anything I have tried so far.
        ' So the new plan is to simply emulate their strategy!
        
        'The only thing we really need to determine dynamically at run-time is the position of the "lock aspect ratio" button, which
        ' will vary based on the width of the translated "width" and "height" captions.
        Dim hOffset As Long
        hOffset = lblWidth.Left
        If lblHeight.Left < lblWidth.Left Then hOffset = lblHeight.Left
        
        hOffset = hOffset - cmdAspectRatio.Width - fixDPI(12)
        If hOffset < 0 Then hOffset = 0
        
        cmdAspectRatio.Left = hOffset
        
    End If

End Sub

'If "Lock Image Aspect Ratio" is selected, these two routines keep all values in sync
Private Sub tudHeight_Change()
    If Not unitSyncingSuspended Then syncDimensions False
End Sub

Private Sub tudWidth_Change()
    If Not unitSyncingSuspended Then syncDimensions True
End Sub

'If the preserve aspect ratio button is pressed, update the height box to reflect the image's current aspect ratio
Private Sub ChkRatio_Click()
    syncDimensions True
End Sub

Private Sub UserControl_Terminate()
    
    'When the control is terminated, release the subclassing used for transparent backgrounds
    If g_IsProgramCompiled And g_IsThemingEnabled And g_IsVistaOrLater Then g_Themer.releaseContainerSubclass UserControl.hWnd
    
End Sub

'When one dimension is updated, call this to synchronize the other (as necessary) and/or the aspect ratio
Private Sub syncDimensions(ByVal useWidthAsSource As Boolean)

    'Suspend automatic text box syncing as necessary
    If useWidthAsSource Then allowedToUpdateWidth = False Else allowedToUpdateHeight = False
    
    'Cache a "preserve aspect ratio" value, which individual functions can use as necessary
    Dim preserveAspectRatio As Boolean
    preserveAspectRatio = cmdAspectRatio.Value
    
    'Because the resize dialog now allows use of units other than pixels (e.g. "percent"), we always provide a width/height pixel
    ' equivalent, in case subsequent conversion functions needs it.
    Dim imgWidthPixels As Long, imgHeightPixels As Long
    imgWidthPixels = getImageWidthInPixels(cmbWidthUnit.ListIndex)
    imgHeightPixels = getImageHeightInPixels(cmbHeightUnit.ListIndex)
    
    'Synchronization is divided into two possible code paths: synchronizing height to match width, and width to match height.
    ' These could technically be merged down to a single path, but I find it more intuitive to handle them separately (despite
    ' the redundant code necessary to do so).
    If useWidthAsSource Then
        
        'When changing width, do not also update height unless "preserve aspect ratio" is checked
        If cmdAspectRatio.Value And allowedToUpdateHeight Then
            
            'The HEIGHT text value needs to be synched to the WIDTH text value.  How we do this depends on the current resize unit.
            Select Case cmbWidthUnit.ListIndex
            
                'Percent
                Case MU_PERCENT
                    tudHeight = tudWidth
                
                'Pixels
                Case MU_PIXELS
                    tudHeight = Int((imgWidthPixels * hRatio) + 0.5)
            
            End Select
            
        End If
        
    Else
        
        'When changing height, do not also update width unless "preserve aspect ratio" is checked
        If cmdAspectRatio.Value And allowedToUpdateWidth Then
        
            'The WIDTH text value needs to be synched to the HEIGHT text value.  How we do this depends on the current resize unit.
            Select Case cmbWidthUnit.ListIndex
        
                'Percent
                Case MU_PERCENT
                    tudWidth = tudHeight
                
                'Pixels
                Case MU_PIXELS
                    tudWidth = Int((imgHeightPixels * wRatio) + 0.5)
                
            End Select
            
        End If
        
    End If
    
    'Re-enable automatic text box syncing
    If useWidthAsSource Then allowedToUpdateWidth = True Else allowedToUpdateHeight = True
    
    'Display a relevant aspect ratio for the current
    updateAspectRatio
    
    RaiseEvent Change(getImageWidthInPixels(cmbWidthUnit.ListIndex), getImageHeightInPixels(cmbHeightUnit.ListIndex), tudWidth, tudHeight)

End Sub

'This control displays an approximate aspect ratio for the selected dimensions.  This can be helpful when
' trying to select new width/height values for a specific application with a set aspect ratio (e.g. 16:9 screens).
Private Sub updateAspectRatio()

    Dim wholeNumber As Double, Numerator As Double, Denominator As Double
    
    If tudWidth.IsValid And tudHeight.IsValid Then
        convertToFraction getImageWidthInPixels(cmbWidthUnit.ListIndex) / getImageHeightInPixels(cmbHeightUnit.ListIndex), wholeNumber, Numerator, Denominator, 4, 99.9
        
        'Aspect ratios are typically given in terms of base 10 if possible, so change values like 8:5 to 16:10
        If CLng(Denominator) = 5 Then
            Numerator = Numerator * 2
            Denominator = Denominator * 2
        End If
        
        lblAspectRatio(1).Caption = " " & Numerator & ":" & Denominator
        
        'While we're here, also update the dimensions caption
        lblDimensions(1).Caption = " " & Int(getImageWidthInPixels(cmbWidthUnit.ListIndex)) & " px   X   " & Int(getImageHeightInPixels(cmbHeightUnit.ListIndex)) & " px"
    
    Else
        lblAspectRatio(1).Caption = ""
        lblDimensions(1).Caption = ""
    End If

End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

    'Store all associated properties
    With PropBag
        .WriteProperty "Font", mFont, "Tahoma"
    End With

End Sub

'These functions can be used to return the image's width, in pixels, that corresponds to the user's current input for the width box
' (taking into account the unit specified in the neighboring dropdown).
Private Function getImageWidthInPixels(ByVal UnitOfMeasurement As MeasurementUnit) As Double

    'If the current width value is invalid, this function will simply return the original image width
    If Not tudWidth.IsValid Then
        getImageWidthInPixels = initWidth
    Else

        'The translation function used depends on the currently selected unit
        Select Case UnitOfMeasurement
        
            'Percent
            Case MU_PERCENT
                getImageWidthInPixels = CDbl(tudWidth / 100) * initWidth
            
            'Pixels
            Case MU_PIXELS
                getImageWidthInPixels = tudWidth
        
        End Select
    
    End If

End Function

'These functions can be used to return the image's height, in pixels, that corresponds to the user's current input for the height box
' (taking into account the unit specified in the neighboring dropdown)
Private Function getImageHeightInPixels(ByVal UnitOfMeasurement As MeasurementUnit) As Double

    'If the current height value is invalid, this function will simply return the original image height
    If Not tudHeight.IsValid Then
        getImageHeightInPixels = initHeight
    Else

        'The translation function used depends on the currently selected unit
        Select Case UnitOfMeasurement
        
            'Percent
            Case MU_PERCENT
                getImageHeightInPixels = CDbl(tudHeight / 100) * initHeight
            
            'Pixels
            Case MU_PIXELS
                getImageHeightInPixels = tudHeight
        
        End Select
        
    End If

End Function

'Given a width measurement in pixels, convert it to some other unit of measurement
Private Function getCustomWidthValue(ByVal UnitOfMeasurement As MeasurementUnit, ByVal srcPixelWidth As Double) As Double

    Select Case UnitOfMeasurement
    
        Case MU_PERCENT
            getCustomWidthValue = (srcPixelWidth / initWidth) * 100
        
        Case MU_PIXELS
            getCustomWidthValue = srcPixelWidth
    
    End Select

End Function

'Given a height measurement in pixels, convert it to some other unit of measurement
Private Function getCustomHeightValue(ByVal UnitOfMeasurement As MeasurementUnit, ByVal srcPixelHeight As Double) As Double

    Select Case UnitOfMeasurement
    
        Case MU_PERCENT
            getCustomHeightValue = (srcPixelHeight / initHeight) * 100
        
        Case MU_PIXELS
            getCustomHeightValue = srcPixelHeight
    
    End Select

End Function
