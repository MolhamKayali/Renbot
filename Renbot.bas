' ******************************************************************************
' * Title         : Renbot                                                     *
' * Version       : 1.0                                                        *
' * Last Updated  : 02.16.2016                                                 *
' * Target Board  : Atmel 128A module                                          *
' * Target MCU    : ATMega128A                                                 *
' * Author        : Molham Kayali                                              *
' * IDE           : BASCOM AVR 2.0.7.5                                         *
' * Peripherals   : Motors Control                                             *
' * Description   : Robot control - Aotonmous                                             *
' ******************************************************************************

'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'-----------------------[Definitions]
Declare Function Pir1() As Byte
Declare Function Pir2() As Byte

$regfile = "m128def.dat"
$crystal = 8000000
$baud = 9600
'$Sim
'-----------------------
'-----------------------[GPIO Configurations]
Config Pine.0 = Output : Dc1 Alias Porte.0 : Reset Dc1
Config Pine.2 = Output : Dc2 Alias Porte.2 : Reset Dc2
Config Pine.4 = Output : Dc3 Alias Porte.4 : Reset Dc3
Config Pine.6 = Output : Dc4 Alias Porte.6 : Reset Dc4
Config Pind.0 = Output : Dc5 Alias Portd.0 : Reset Dc5
Config Pind.2 = Output : Dc6 Alias Portd.2 : Reset Dc6
Config Pind.4 = Output : Dc7 Alias Portd.4 : Reset Dc7
Config Pind.6 = Output : Dc8 Alias Portd.6 : Reset Dc8
Config Pine.1 = Output : Eyel1 Alias Porte.1 : Set Eyel1
Config Pine.3 = Output : Eyel2 Alias Porte.3 : Set Eyel2

Config Pinf.0 = Input
Config Pinf.1 = Input
Config Adc = Single , Prescaler = Auto , Reference = Internal

Gosub Eyes

Dim Motion As Byte
Dim Motion2 As Byte


Start Adc
Wait 3
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'--->[Main Program]


Do
   Motion = Pir1()
   Motion2 = Pir2()
    If Motion = 1 Then

     Gosub Turn_right : Waitms 200
     Gosub Move_backward : Waitms 200

    Elseif Motion2 = 1 Then
     Gosub Turn_left : Waitms 200
     Gosub Move_forward : Waitms 200

    Else

     Gosub Move_forward : Wait 1
   'Gosub Move_backward : Wait 1
   'Gosub Turn_right : Wait 1
   'Gosub Turn_left : Wait 1
   'Gosub Move2_forward : Wait 1
   'Gosub Move2_backward : Wait 1
   End If
   'Gosub Eyes : Wait 1
   'Gosub Blink_eye : Wait 1
   'Gosub Eyes : Wait 1



Loop
End
'---<[End Main]
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

'--->[Move Renbot with 4 motors forward]
Move_forward:

   Set Dc1 : Reset Dc2 : Set Dc3 : Reset Dc4
   Reset Dc5 : Set Dc6 : Reset Dc7 : Set Dc8
   Waitms 100
Return
'-----------------------

'--->[Move Renbot with 4 motors backward ]
Move_backward:

   Reset Dc1 : Set Dc2 : Reset Dc3 : Set Dc4
   Set Dc5 : Reset Dc6 : Set Dc7 : Reset Dc8
   Waitms 100
Return
'-----------------------

'--->[Turn Renbot with 4 motors right ]
Turn_right:

   Set Dc1 : Reset Dc2 : Set Dc3 : Reset Dc4
   Set Dc5 : Reset Dc6 : Set Dc7 : Reset Dc8
   Waitms 100
Return
'-----------------------

'--->[Turn Renbot with 4 motors left ]
Turn_left:

   Reset Dc1 : Set Dc2 : Reset Dc3 : Set Dc4
   Reset Dc5 : Set Dc6 : Reset Dc7 : Set Dc8
   Waitms 100
Return
'-----------------------

'--->[Move Renbot with 2 motors forward]
Move2_forward:

   Set Dc1 : Reset Dc2 : Reset Dc3 : Reset Dc4
   Reset Dc5 : Set Dc6 : Reset Dc7 : Reset Dc8
   Waitms 100
Return
'-----------------------

'--->[Move Renbot with 2 motors backward ]
Move2_backward:

   Reset Dc1 : Set Dc2 : Reset Dc3 : Reset Dc4
   Set Dc5 : Reset Dc6 : Reset Dc7 : Reset Dc8
   Waitms 100
Return
'-----------------------

'--->[Blink Renbot LED eyes]
Eyes:

   Set Eyel1 : Reset Eyel2
   Waitms 200

   Reset Eyel1 : Reset Eyel2
   Waitms 100

   Set Eyel1 : Reset Eyel2
   Waitms 100

   Reset Eyel1 : Reset Eyel2
   Waitms 50

Return
'-----------------------

'--->[Blink Renbot LED eyes]
Blink_eye:

   Set Eyel1 : Reset Eyel2
   Waitms 50

   Reset Eyel1 : Reset Eyel2
   Waitms 50

   Set Eyel1 : Reset Eyel2
   Waitms 50

Return
'-----------------------

'--->[Front PIR sensor]
Function Pir1() As Byte
Local Adcvalue As Integer


      Adcvalue = Getadc(0)
    If Adcvalue < 512 Then
      Motion = 1

    Else
      Motion = 0

    End If
End Function

'-----------------------

'--->[Back PIR sensor]
Function Pir2() As Byte
Local Adcvalue As Integer


      Adcvalue = Getadc(1)
    If Adcvalue < 512 Then
      Motion2 = 1

    Else
      Motion2 = 0

    End If
End Function
