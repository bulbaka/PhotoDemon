VERSION 5.00
Begin VB.Form toolpanel_FancyText 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   ClientHeight    =   1515
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   18435
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   101
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   1229
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin PhotoDemon.buttonStripVertical btsCategory 
      Height          =   1380
      Left            =   6240
      TabIndex        =   1
      Top             =   30
      Width           =   2175
      _extentx        =   4048
      _extenty        =   2434
   End
   Begin PhotoDemon.pdTextBox txtTextTool 
      Height          =   1380
      Left            =   840
      TabIndex        =   0
      Top             =   30
      Width           =   5295
      _extentx        =   9340
      _extenty        =   2434
      fontsize        =   9
      multiline       =   -1  'True
   End
   Begin PhotoDemon.pdLabel lblText 
      Height          =   240
      Index           =   1
      Left            =   120
      Top             =   60
      Width           =   645
      _extentx        =   1138
      _extenty        =   503
      alignment       =   1
      caption         =   "text:"
      forecolor       =   0
   End
   Begin VB.PictureBox picCategory 
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Height          =   1500
      Index           =   2
      Left            =   8520
      ScaleHeight     =   100
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   729
      TabIndex        =   6
      Top             =   0
      Visible         =   0   'False
      Width           =   10935
      Begin PhotoDemon.buttonStripVertical btsAppearanceCategory 
         Height          =   1380
         Left            =   30
         TabIndex        =   9
         Top             =   30
         Width           =   1815
         _extentx        =   3201
         _extenty        =   2434
      End
      Begin VB.PictureBox picAppearanceCategory 
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         Height          =   1500
         Index           =   1
         Left            =   1920
         ScaleHeight     =   100
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   729
         TabIndex        =   11
         Top             =   0
         Visible         =   0   'False
         Width           =   10935
         Begin PhotoDemon.penSelector psTextBackground 
            Height          =   855
            Left            =   4920
            TabIndex        =   40
            Top             =   540
            Width           =   2055
            _extentx        =   3625
            _extenty        =   1508
         End
         Begin PhotoDemon.brushSelector bsTextBackground 
            Height          =   855
            Left            =   1440
            TabIndex        =   38
            Top             =   540
            Width           =   2055
            _extentx        =   3625
            _extenty        =   1508
         End
         Begin PhotoDemon.smartCheckBox chkBackground 
            Height          =   330
            Left            =   195
            TabIndex        =   12
            Top             =   105
            Width           =   3240
            _extentx        =   4445
            _extenty        =   582
            caption         =   "fill background"
            value           =   0
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   720
            Index           =   15
            Left            =   0
            Top             =   600
            Width           =   1245
            _extentx        =   1561
            _extenty        =   1270
            alignment       =   1
            caption         =   "fill style:"
            forecolor       =   0
            layout          =   1
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   720
            Index           =   28
            Left            =   3600
            Top             =   600
            Width           =   1125
            _extentx        =   1561
            _extenty        =   1270
            alignment       =   1
            caption         =   "border style:"
            forecolor       =   0
            layout          =   1
         End
         Begin PhotoDemon.smartCheckBox chkBackgroundBorder 
            Height          =   330
            Left            =   3840
            TabIndex        =   39
            Top             =   120
            Width           =   3240
            _extentx        =   4445
            _extenty        =   582
            caption         =   "background border"
            value           =   0
         End
      End
      Begin VB.PictureBox picAppearanceCategory 
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         Height          =   1500
         Index           =   0
         Left            =   1920
         ScaleHeight     =   100
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   729
         TabIndex        =   10
         Top             =   0
         Visible         =   0   'False
         Width           =   10935
         Begin PhotoDemon.penSelector psText 
            Height          =   855
            Left            =   4680
            TabIndex        =   42
            Top             =   480
            Width           =   2055
            _extentx        =   3625
            _extenty        =   1508
         End
         Begin PhotoDemon.brushSelector bsText 
            Height          =   855
            Left            =   1200
            TabIndex        =   37
            Top             =   480
            Width           =   2055
            _extentx        =   3625
            _extenty        =   1508
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   855
            Index           =   6
            Left            =   0
            Top             =   480
            Width           =   1095
            _extentx        =   1931
            _extenty        =   1508
            alignment       =   1
            caption         =   "fill style:"
            layout          =   1
         End
         Begin PhotoDemon.smartCheckBox chkFillText 
            Height          =   330
            Left            =   120
            TabIndex        =   36
            Top             =   30
            Width           =   3135
            _extentx        =   5530
            _extenty        =   582
            caption         =   "fill text"
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   855
            Index           =   7
            Left            =   3360
            Top             =   480
            Width           =   1215
            _extentx        =   2143
            _extenty        =   1508
            alignment       =   1
            caption         =   "outline style:"
            layout          =   1
         End
         Begin PhotoDemon.smartCheckBox chkOutlineText 
            Height          =   330
            Left            =   3480
            TabIndex        =   41
            Top             =   30
            Width           =   3135
            _extentx        =   5530
            _extenty        =   582
            caption         =   "outline text"
         End
      End
   End
   Begin VB.PictureBox picCategory 
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Height          =   1500
      Index           =   1
      Left            =   8520
      ScaleHeight     =   100
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   729
      TabIndex        =   3
      Top             =   0
      Visible         =   0   'False
      Width           =   10935
      Begin PhotoDemon.textUpDown tudLineSpacing 
         Height          =   345
         Left            =   5160
         TabIndex        =   17
         Top             =   1020
         Width           =   1935
         _extentx        =   3413
         _extenty        =   609
         sigdigits       =   2
         min             =   -10
      End
      Begin PhotoDemon.textUpDown tudMargin 
         Height          =   345
         Index           =   0
         Left            =   5160
         TabIndex        =   13
         Top             =   90
         Width           =   960
         _extentx        =   1693
         _extenty        =   609
         max             =   1000
         min             =   -1000
      End
      Begin PhotoDemon.buttonStrip btsHAlignment 
         Height          =   435
         Left            =   1320
         TabIndex        =   4
         Top             =   60
         Width           =   1455
         _extentx        =   2566
         _extenty        =   767
         colorscheme     =   1
      End
      Begin PhotoDemon.pdLabel lblText 
         Height          =   240
         Index           =   8
         Left            =   0
         Top             =   150
         Width           =   1125
         _extentx        =   1984
         _extenty        =   503
         alignment       =   1
         caption         =   "alignment:"
         forecolor       =   0
      End
      Begin PhotoDemon.buttonStrip btsVAlignment 
         Height          =   435
         Left            =   1320
         TabIndex        =   5
         Top             =   510
         Width           =   1455
         _extentx        =   2566
         _extenty        =   767
         colorscheme     =   1
      End
      Begin PhotoDemon.pdLabel lblText 
         Height          =   240
         Index           =   0
         Left            =   0
         Top             =   1080
         Width           =   1125
         _extentx        =   1984
         _extenty        =   503
         alignment       =   1
         caption         =   "line wrap:"
         forecolor       =   0
      End
      Begin PhotoDemon.pdComboBox cboWordWrap 
         Height          =   375
         Left            =   1320
         TabIndex        =   8
         Top             =   1020
         Width           =   2070
         _extentx        =   3651
         _extenty        =   661
      End
      Begin PhotoDemon.pdLabel lblText 
         Height          =   240
         Index           =   23
         Left            =   3360
         Top             =   150
         Width           =   1605
         _extentx        =   2831
         _extenty        =   503
         alignment       =   1
         caption         =   "h. padding:"
         forecolor       =   0
      End
      Begin PhotoDemon.textUpDown tudMargin 
         Height          =   345
         Index           =   1
         Left            =   6120
         TabIndex        =   14
         Top             =   90
         Width           =   960
         _extentx        =   1693
         _extenty        =   609
         max             =   1000
         min             =   -1000
      End
      Begin PhotoDemon.textUpDown tudMargin 
         Height          =   345
         Index           =   2
         Left            =   5160
         TabIndex        =   15
         Top             =   570
         Width           =   960
         _extentx        =   1693
         _extenty        =   609
         max             =   1000
         min             =   -1000
      End
      Begin PhotoDemon.textUpDown tudMargin 
         Height          =   345
         Index           =   3
         Left            =   6120
         TabIndex        =   16
         Top             =   570
         Width           =   960
         _extentx        =   1693
         _extenty        =   609
         max             =   1000
         min             =   -1000
      End
      Begin PhotoDemon.pdLabel lblText 
         Height          =   240
         Index           =   24
         Left            =   3360
         Top             =   630
         Width           =   1605
         _extentx        =   2831
         _extenty        =   503
         alignment       =   1
         caption         =   "v. padding:"
         forecolor       =   0
      End
      Begin PhotoDemon.pdLabel lblText 
         Height          =   240
         Index           =   25
         Left            =   3480
         Top             =   1080
         Width           =   1530
         _extentx        =   2699
         _extenty        =   503
         alignment       =   1
         caption         =   "line spacing:"
         forecolor       =   0
      End
   End
   Begin VB.PictureBox picCategory 
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Height          =   1500
      Index           =   0
      Left            =   8520
      ScaleHeight     =   100
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   729
      TabIndex        =   2
      Top             =   0
      Width           =   10935
      Begin PhotoDemon.buttonStripVertical btsCharCategory 
         Height          =   1380
         Left            =   0
         TabIndex        =   18
         Top             =   30
         Width           =   1815
         _extentx        =   3201
         _extenty        =   2434
      End
      Begin VB.PictureBox picCharCategory 
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         Height          =   1500
         Index           =   1
         Left            =   1920
         ScaleHeight     =   100
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   729
         TabIndex        =   28
         Top             =   60
         Visible         =   0   'False
         Width           =   10935
         Begin PhotoDemon.textUpDown tudJitter 
            Height          =   345
            Index           =   0
            Left            =   5280
            TabIndex        =   33
            Top             =   0
            Width           =   1215
            _extentx        =   1720
            _extenty        =   609
            sigdigits       =   1
            max             =   100
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   26
            Left            =   0
            Top             =   60
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "remap:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdComboBox cboCharCase 
            Height          =   375
            Left            =   1320
            TabIndex        =   29
            Top             =   0
            Width           =   2595
            _extentx        =   4577
            _extenty        =   661
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   30
            Left            =   0
            Top             =   540
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "spacing:"
            forecolor       =   0
         End
         Begin PhotoDemon.sliderTextCombo sltCharSpacing 
            CausesValidation=   0   'False
            Height          =   495
            Left            =   1200
            TabIndex        =   30
            Top             =   420
            Width           =   2760
            _extentx        =   4868
            _extenty        =   873
            sigdigits       =   3
            max             =   1
            min             =   -1
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   31
            Left            =   0
            Top             =   1020
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "orientation:"
            forecolor       =   0
         End
         Begin PhotoDemon.sliderTextCombo sltCharOrientation 
            CausesValidation=   0   'False
            Height          =   495
            Left            =   1200
            TabIndex        =   31
            Top             =   900
            Width           =   2760
            _extentx        =   4868
            _extenty        =   873
            sigdigits       =   1
            max             =   360
            min             =   -360
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   32
            Left            =   3960
            Top             =   60
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "jitter:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   33
            Left            =   4125
            Top             =   1020
            Width           =   960
            _extentx        =   1693
            _extenty        =   503
            alignment       =   1
            caption         =   "mirror:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdComboBox cboCharMirror 
            Height          =   375
            Left            =   5280
            TabIndex        =   32
            Top             =   945
            Width           =   2595
            _extentx        =   4577
            _extenty        =   661
         End
         Begin PhotoDemon.textUpDown tudJitter 
            Height          =   345
            Index           =   1
            Left            =   6675
            TabIndex        =   34
            Top             =   0
            Width           =   1215
            _extentx        =   2143
            _extenty        =   609
            sigdigits       =   1
            max             =   100
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   34
            Left            =   3960
            Top             =   540
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "inflation:"
            forecolor       =   0
         End
         Begin PhotoDemon.sliderTextCombo sltCharInflation 
            CausesValidation=   0   'False
            Height          =   495
            Left            =   5160
            TabIndex        =   35
            Top             =   420
            Width           =   2760
            _extentx        =   4868
            _extenty        =   873
            sigdigits       =   1
            max             =   20
         End
      End
      Begin VB.PictureBox picCharCategory 
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         Height          =   1500
         Index           =   0
         Left            =   1920
         ScaleHeight     =   100
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   729
         TabIndex        =   19
         Top             =   60
         Visible         =   0   'False
         Width           =   10935
         Begin PhotoDemon.textUpDown tudTextFontSize 
            Height          =   345
            Left            =   1320
            TabIndex        =   20
            Top             =   450
            Width           =   2415
            _extentx        =   4260
            _extenty        =   609
            max             =   1000
            min             =   1
            value           =   16
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   3
            Left            =   0
            Top             =   60
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "font face:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   4
            Left            =   0
            Top             =   510
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "font size:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   2
            Left            =   0
            Top             =   960
            Width           =   1125
            _extentx        =   1984
            _extenty        =   503
            alignment       =   1
            caption         =   "font style:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdButtonToolbox btnFontStyles 
            Height          =   435
            Index           =   1
            Left            =   1800
            TabIndex        =   21
            Top             =   870
            Width           =   450
            _extentx        =   794
            _extenty        =   767
            stickytoggle    =   -1  'True
         End
         Begin PhotoDemon.pdButtonToolbox btnFontStyles 
            Height          =   435
            Index           =   2
            Left            =   2280
            TabIndex        =   22
            Top             =   870
            Width           =   450
            _extentx        =   794
            _extenty        =   767
            stickytoggle    =   -1  'True
         End
         Begin PhotoDemon.pdButtonToolbox btnFontStyles 
            Height          =   435
            Index           =   3
            Left            =   2760
            TabIndex        =   23
            Top             =   870
            Width           =   450
            _extentx        =   794
            _extenty        =   767
            stickytoggle    =   -1  'True
         End
         Begin PhotoDemon.smartCheckBox chkHinting 
            Height          =   330
            Left            =   4200
            TabIndex        =   24
            Top             =   450
            Width           =   1815
            _extentx        =   2990
            _extenty        =   582
            caption         =   "hinting"
            value           =   0
         End
         Begin PhotoDemon.pdComboBox cboTextRenderingHint 
            Height          =   375
            Left            =   5400
            TabIndex        =   25
            Top             =   0
            Width           =   2415
            _extentx        =   4260
            _extenty        =   635
         End
         Begin PhotoDemon.pdLabel lblText 
            Height          =   240
            Index           =   5
            Left            =   3840
            Top             =   60
            Width           =   1365
            _extentx        =   2408
            _extenty        =   503
            alignment       =   1
            caption         =   "antialiasing:"
            forecolor       =   0
         End
         Begin PhotoDemon.pdComboBox_Font cboTextFontFace 
            Height          =   375
            Left            =   1320
            TabIndex        =   26
            Top             =   0
            Width           =   2415
            _extentx        =   4260
            _extenty        =   661
         End
         Begin PhotoDemon.pdButtonToolbox btnFontStyles 
            Height          =   435
            Index           =   0
            Left            =   1320
            TabIndex        =   27
            Top             =   870
            Width           =   450
            _extentx        =   794
            _extenty        =   767
            stickytoggle    =   -1  'True
         End
      End
   End
   Begin VB.PictureBox picCategory 
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Height          =   1500
      Index           =   3
      Left            =   8520
      ScaleHeight     =   100
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   729
      TabIndex        =   7
      Top             =   0
      Visible         =   0   'False
      Width           =   10935
   End
End
Attribute VB_Name = "toolpanel_FancyText"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************************
'PhotoDemon Advanced Typography Tool Panel
'Copyright 2013-2015 by Tanner Helland
'Created: 02/Oct/13
'Last updated: 13/May/15
'Last update: finish migrating all relevant controls to this dedicated form
'
'This form includes all user-editable settings for PD's Advanced Typography text tool.
'
'All source code in this file is licensed under a modified BSD license.  This means you may use the code in your own
' projects IF you provide attribution.  For more information, please visit http://photodemon.org/about/license/
'
'***************************************************************************

Option Explicit

'The value of all controls on this form are saved and loaded to file by this class
Private WithEvents lastUsedSettings As pdLastUsedSettings
Attribute lastUsedSettings.VB_VarHelpID = -1

'Current list of fonts, in pdStringStack format
Private userFontList As pdStringStack

Private Sub bsText_BrushChanged()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FillBrush, bsText.Brush
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub bsText_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_FillBrush, bsText.Brush, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub bsText_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FillBrush, bsText.Brush
End Sub

Private Sub bsTextBackground_BrushChanged()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_BackgroundBrush, bsTextBackground.Brush
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub bsTextBackground_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_BackgroundBrush, bsTextBackground.Brush, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub bsTextBackground_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_BackgroundBrush, bsTextBackground.Brush
End Sub

Private Sub btnFontStyles_Click(Index As Integer)
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update whichever style was toggled
    Select Case Index
    
        'Bold
        Case 0
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontBold, btnFontStyles(Index).Value
        
        'Italic
        Case 1
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontItalic, btnFontStyles(Index).Value
        
        'Underline
        Case 2
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontUnderline, btnFontStyles(Index).Value
        
        'Strikeout
        Case 3
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontStrikeout, btnFontStyles(Index).Value
    
    End Select
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)

End Sub

Private Sub btnFontStyles_GotFocusAPI(Index As Integer)
    
    'Non-destructive effects are obviously not tracked if no images are loaded
    If g_OpenImageCount = 0 Then Exit Sub
    
    'Set Undo/Redo markers for whichever button was toggled
    Select Case Index
    
        'Bold
        Case 0
            Processor.flagInitialNDFXState_Text ptp_FontBold, btnFontStyles(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
            
        'Italic
        Case 1
            Processor.flagInitialNDFXState_Text ptp_FontItalic, btnFontStyles(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
        'Underline
        Case 2
            Processor.flagInitialNDFXState_Text ptp_FontUnderline, btnFontStyles(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
        'Strikeout
        Case 3
            Processor.flagInitialNDFXState_Text ptp_FontStrikeout, btnFontStyles(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
    
    End Select
    
End Sub

Private Sub btnFontStyles_LostFocusAPI(Index As Integer)
    
    'Evaluate Undo/Redo markers for whichever button was toggled
    Select Case Index
    
        'Bold
        Case 0
            If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontBold, btnFontStyles(Index).Value
            
        'Italic
        Case 1
            If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontItalic, btnFontStyles(Index).Value
        
        'Underline
        Case 2
            If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontUnderline, btnFontStyles(Index).Value
        
        'Strikeout
        Case 3
            If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontStrikeout, btnFontStyles(Index).Value
    
    End Select
    
End Sub

Private Sub btsAppearanceCategory_Click(ByVal buttonIndex As Long)
    
    'When the current category is changed, show the relevant panel and hide all others
    Dim i As Long
    For i = 0 To btsAppearanceCategory.ListCount - 1
        picAppearanceCategory(i).Visible = CBool(i = buttonIndex)
    Next i
    
End Sub

Private Sub btsCategory_Click(ByVal buttonIndex As Long)
    
    'When the current category is changed, show the relevant panel and hide all others
    Dim i As Long
    For i = 0 To btsCategory.ListCount - 1
        picCategory(i).Visible = CBool(i = buttonIndex)
    Next i
    
End Sub

Private Sub btsCharCategory_Click(ByVal buttonIndex As Long)
    
    'When the current category is changed, show the relevant panel and hide all others
    Dim i As Long
    For i = 0 To btsCharCategory.ListCount - 1
        picCharCategory(i).Visible = CBool(i = buttonIndex)
    Next i
    
End Sub

Private Sub btsHAlignment_Click(ByVal buttonIndex As Long)
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_HorizontalAlignment, buttonIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub btsHAlignment_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_HorizontalAlignment, btsHAlignment.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub btsHAlignment_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_HorizontalAlignment, btsHAlignment.ListIndex
End Sub

Private Sub btsVAlignment_Click(ByVal buttonIndex As Long)
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_VerticalAlignment, buttonIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub btsVAlignment_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_VerticalAlignment, btsVAlignment.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub btsVAlignment_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_VerticalAlignment, btsVAlignment.ListIndex
End Sub

Private Sub cboCharCase_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharRemap, cboCharCase.ListIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub cboCharCase_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharRemap, cboCharCase.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub cboCharCase_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharRemap, cboCharCase.ListIndex
End Sub

Private Sub cboCharMirror_Click()

    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharMirror, cboCharMirror.ListIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)

End Sub

Private Sub cboCharMirror_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharMirror, cboCharMirror.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub cboCharMirror_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharMirror, cboCharMirror.ListIndex
End Sub

Private Sub cboTextFontFace_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer font size
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontFace, cboTextFontFace.List(cboTextFontFace.ListIndex)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub cboTextFontFace_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_FontFace, cboTextFontFace.List(cboTextFontFace.ListIndex), pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub cboTextFontFace_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontFace, cboTextFontFace.List(cboTextFontFace.ListIndex)
End Sub

Private Sub cboTextRenderingHint_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_TextAntialiasing, cboTextRenderingHint.ListIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub cboTextRenderingHint_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_TextAntialiasing, cboTextRenderingHint.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub cboTextRenderingHint_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_TextAntialiasing, cboTextRenderingHint.ListIndex
End Sub

Private Sub cboWordWrap_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_WordWrap, cboWordWrap.ListIndex
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub cboWordWrap_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_WordWrap, cboWordWrap.ListIndex, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub cboWordWrap_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_WordWrap, cboWordWrap.ListIndex
End Sub

Private Sub chkBackground_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_BackgroundActive, CBool(chkBackground.Value)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub chkBackground_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_BackgroundActive, CBool(chkBackground.Value), pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub chkBackground_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_BackgroundActive, CBool(chkBackground.Value)
End Sub

Private Sub chkBackgroundBorder_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_BackBorderActive, CBool(chkBackgroundBorder.Value)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub chkBackgroundBorder_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_BackBorderActive, CBool(chkBackgroundBorder.Value), pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub chkBackgroundBorder_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_BackBorderActive, CBool(chkBackgroundBorder.Value)
End Sub

Private Sub chkFillText_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FillActive, CBool(chkFillText.Value)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub chkFillText_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_FillActive, chkFillText.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub chkFillText_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FillActive, chkFillText.Value
End Sub

Private Sub chkHinting_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_TextHinting, CBool(chkHinting.Value)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub chkHinting_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_TextHinting, CBool(chkHinting.Value), pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub chkHinting_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_TextHinting, CBool(chkHinting.Value)
End Sub

Private Sub chkOutlineText_Click()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_OutlineActive, CBool(chkOutlineText.Value)
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub chkOutlineText_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_OutlineActive, chkOutlineText.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub chkOutlineText_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_OutlineActive, chkOutlineText.Value
End Sub

Private Sub Form_Load()

    'Generate a list of fonts
    If g_IsProgramRunning Then
        
        'Initialize the font list
        cboTextFontFace.initializeFontList
        
        'Set the system font as the default
        cboTextFontFace.setListIndexByString g_InterfaceFont, vbBinaryCompare
    
        'Draw the primary category selector
        btsCategory.AddItem "character", 0
        btsCategory.AddItem "paragraph", 1
        btsCategory.AddItem "visual", 2
        
        'I've already stubbed out a 4th options panel, but the vertical button list is *really* cramped, so another solution might be necessary
        
        'Draw the character sub-category selector
        btsCharCategory.AddItem "font", 0
        btsCharCategory.AddItem "special", 1
        btsCharCategory.ListIndex = 0
        
        'OpenType-specific features are a big investment, so I've postponed them to a later date
        'If g_IsVistaOrLater Then btsCharCategory.AddItem "OpenType", 2
        
        'Fill AA options
        cboTextRenderingHint.Clear
        cboTextRenderingHint.AddItem "none", 0
        cboTextRenderingHint.AddItem "normal", 1
        cboTextRenderingHint.AddItem "crisp", 2
        cboTextRenderingHint.ListIndex = 1
        
        'Draw font style buttons
        btnFontStyles(0).AssignImage "TEXT_BOLD"
        btnFontStyles(1).AssignImage "TEXT_ITALIC"
        btnFontStyles(2).AssignImage "TEXT_UNDERLINE"
        btnFontStyles(3).AssignImage "TEXT_STRIKE"
        
        'Draw alignment buttons
        btsHAlignment.AddItem "", 0
        btsHAlignment.AddItem "", 1
        btsHAlignment.AddItem "", 2
        
        btsHAlignment.AssignImageToItem 0, "TEXT_ALIGN_LEFT"
        btsHAlignment.AssignImageToItem 1, "TEXT_ALIGN_HCENTER"
        btsHAlignment.AssignImageToItem 2, "TEXT_ALIGN_RIGHT"
        
        btsVAlignment.AddItem "", 0
        btsVAlignment.AddItem "", 1
        btsVAlignment.AddItem "", 2
        
        btsVAlignment.AssignImageToItem 0, "TEXT_ALIGN_TOP"
        btsVAlignment.AssignImageToItem 1, "TEXT_ALIGN_VCENTER"
        btsVAlignment.AssignImageToItem 2, "TEXT_ALIGN_BOTTOM"
        
        'Fill various character positioning settings
        cboCharMirror.Clear
        cboCharMirror.AddItem "none", 0
        cboCharMirror.AddItem "horizontal", 1
        cboCharMirror.AddItem "vertical", 2
        cboCharMirror.AddItem "both", 3
        cboCharMirror.ListIndex = 0
        
        cboCharCase.Clear
        cboCharCase.AddItem "none", 0
        cboCharCase.AddItem "lowercase", 1
        cboCharCase.AddItem "UPPERCASE", 2
        cboCharCase.AddItem "hiragana", 3
        cboCharCase.AddItem "katakana", 4
        cboCharCase.AddItem "simplified Chinese", 5
        cboCharCase.AddItem "traditional Chinese", 6
        If g_IsWin7OrLater Then cboCharCase.AddItem "Titlecase", 7
        cboCharCase.ListIndex = 0
        
        
        'Fill wordwrap options
        cboWordWrap.Clear
        cboWordWrap.AddItem "none", 0
        cboWordWrap.AddItem "manual only", 1
        cboWordWrap.AddItem "characters", 2
        cboWordWrap.AddItem "words", 3
        cboWordWrap.ListIndex = 3
        
        'Draw the appearance sub-category selector
        btsAppearanceCategory.AddItem "text", 0
        btsAppearanceCategory.AddItem "background", 1
        btsAppearanceCategory.ListIndex = 0
        
        'Load any last-used settings for this form
        Set lastUsedSettings = New pdLastUsedSettings
        lastUsedSettings.setParentForm Me
        lastUsedSettings.loadAllControlValues
        
        'Update everything against the current theme.  This will also set tooltips for various controls.
        updateAgainstCurrentTheme
        
    End If

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    
    'Save all last-used settings to file
    lastUsedSettings.saveAllControlValues
    lastUsedSettings.setParentForm Nothing
    
End Sub

Private Sub lastUsedSettings_ReadCustomPresetData()

    'Make sure the correct panels are shown
    btsCategory_Click btsCategory.ListIndex
    btsAppearanceCategory_Click btsAppearanceCategory.ListIndex
    btsCharCategory_Click btsCharCategory.ListIndex

End Sub

Private Sub psText_PenChanged()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_OutlinePen, psText.Pen
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub psText_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_OutlinePen, psText.Pen, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub psText_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_OutlinePen, psText.Pen
End Sub

Private Sub psTextBackground_PenChanged()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_BackBorderPen, psTextBackground.Pen
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub psTextBackground_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_BackBorderPen, psTextBackground.Pen, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub psTextBackground_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_BackBorderPen, psTextBackground.Pen
End Sub

Private Sub sltCharInflation_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharInflation, sltCharInflation.Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub sltCharInflation_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharInflation, sltCharInflation.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub sltCharInflation_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharInflation, sltCharInflation.Value
End Sub

Private Sub sltCharOrientation_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharOrientation, sltCharOrientation.Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub sltCharOrientation_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharOrientation, sltCharOrientation.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub sltCharOrientation_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharOrientation, sltCharOrientation.Value
End Sub

Private Sub sltCharSpacing_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharSpacing, sltCharSpacing.Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub sltCharSpacing_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharSpacing, sltCharSpacing.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub sltCharSpacing_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharSpacing, sltCharSpacing.Value
End Sub

Private Sub tudJitter_Change(Index As Integer)
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
        
    'Update the current layer text alignment
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_CharJitterX + Index, tudJitter(Index).Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub tudJitter_GotFocusAPI(Index As Integer)
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_CharJitterX + Index, tudJitter(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub tudJitter_LostFocusAPI(Index As Integer)
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_CharJitterX + Index, tudJitter(Index).Value
End Sub

Private Sub tudLineSpacing_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the setting
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_LineSpacing, tudLineSpacing.Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub tudLineSpacing_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_LineSpacing, tudLineSpacing.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub tudLineSpacing_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_LineSpacing, tudLineSpacing.Value
End Sub

Private Sub tudMargin_Change(Index As Integer)
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current setting
    Select Case Index
    
        Case 0
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_MarginLeft, tudMargin(Index).Value
        
        Case 1
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_MarginRight, tudMargin(Index).Value
        
        Case 2
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_MarginTop, tudMargin(Index).Value
        
        Case 3
            pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_MarginBottom, tudMargin(Index).Value
    
    End Select
        
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub tudMargin_GotFocusAPI(Index As Integer)

    If g_OpenImageCount = 0 Then Exit Sub
    
    Select Case Index
    
        Case 0
            Processor.flagInitialNDFXState_Text ptp_MarginLeft, tudMargin(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
        Case 1
            Processor.flagInitialNDFXState_Text ptp_MarginRight, tudMargin(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
        Case 2
            Processor.flagInitialNDFXState_Text ptp_MarginTop, tudMargin(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
        Case 3
            Processor.flagInitialNDFXState_Text ptp_MarginBottom, tudMargin(Index).Value, pdImages(g_CurrentImage).getActiveLayerID
        
    End Select
    
End Sub

Private Sub tudMargin_LostFocusAPI(Index As Integer)
    
    If Tool_Support.canvasToolsAllowed Then
        
        Select Case Index
        
            Case 0
                Processor.flagFinalNDFXState_Text ptp_MarginLeft, tudMargin(Index).Value
            
            Case 1
                Processor.flagFinalNDFXState_Text ptp_MarginRight, tudMargin(Index).Value
            
            Case 2
                Processor.flagFinalNDFXState_Text ptp_MarginTop, tudMargin(Index).Value
            
            Case 3
                Processor.flagFinalNDFXState_Text ptp_MarginBottom, tudMargin(Index).Value
        
        End Select
        
    End If
    
End Sub

Private Sub tudTextFontSize_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer font size
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_FontSize, tudTextFontSize.Value
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
    
End Sub

Private Sub tudTextFontSize_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_FontSize, tudTextFontSize.Value, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub tudTextFontSize_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_FontSize, tudTextFontSize.Value
End Sub

Private Sub txtTextTool_Change()
    
    'If tool changes are not allowed, exit.
    ' NOTE: this will also check tool busy status, via Tool_Support.getToolBusyState
    If Not Tool_Support.canvasToolsAllowed Then Exit Sub
    
    'Mark the tool engine as busy
    Tool_Support.setToolBusyState True
    
    'Update the current layer text
    pdImages(g_CurrentImage).getActiveLayer.setTextLayerProperty ptp_Text, txtTextTool.Text
    
    'Free the tool engine
    Tool_Support.setToolBusyState False
    
    'Redraw the viewport
    Viewport_Engine.Stage2_CompositeAllLayers pdImages(g_CurrentImage), FormMain.mainCanvas(0)
        
End Sub

Private Sub txtTextTool_GotFocusAPI()
    If g_OpenImageCount = 0 Then Exit Sub
    Processor.flagInitialNDFXState_Text ptp_Text, txtTextTool.Text, pdImages(g_CurrentImage).getActiveLayerID
End Sub

Private Sub txtTextTool_LostFocusAPI()
    If Tool_Support.canvasToolsAllowed Then Processor.flagFinalNDFXState_Text ptp_Text, txtTextTool.Text
End Sub


'Updating against the current theme accomplishes a number of things:
' 1) All user-drawn controls are redrawn according to the current g_Themer settings.
' 2) All tooltips and captions are translated according to the current language.
' 3) MakeFormPretty is called, which redraws the form itself according to any theme and/or system settings.
'
'This function is called at least once, at Form_Load, but can be called again if the active language or theme changes.
Public Sub updateAgainstCurrentTheme()

    'Start by redrawing the form according to current theme and translation settings.  (This function also takes care of
    ' any common controls that may still exist in the program.)
    makeFormPretty Me

End Sub
