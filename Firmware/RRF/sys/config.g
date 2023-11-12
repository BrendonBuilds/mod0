; Configuration file for Duet 3 Mini 5+ (firmware version 3.4.6)
; executed by the firmware on start-up
;

; General preferences
G90							; send absolute coordinates...
M83							; ...but relative extruder moves
M550 P"mod0"				; set printer name
M669 K1						; select CoreXY mode
M552 S1						; enable wifi

; use out2 for CAN/extruder power
M950 F9 C"out2"
M106 P9 S1
G4 S2						; slight delay for power to enable CAN device

; Network
M586 P0 S1					; enable HTTP
M586 P1 S1					; enable FTP
M586 P2 S0					; disable Telnet

; Drives
M569 P0.0 S0					; physical drive 0.0 goes backwards
M569 P0.2 S1					; physical drive 0.2 goes forwards
M569 P0.3 S0					; physical drive 0.3 goes backwards
M569 P25.0 S0					; physical drive 25.0 goes backwards

M584 X0.0 Y0.3 Z0.2 E25.0					; set drive mapping
M350 X16 Y16 Z16 E16 I1						; configure microstepping with interpolation
M92 X152.38095238 Y152.38095238 Z1600 E398	; set steps per mm
M566 X1100 Y1100 Z200 E300					; set maximum instantaneous speed changes (mm/min)
M203 X60000 Y60000 Z1800 E5000				; set maximum speeds (mm/min)
M201 X6500 Y6500 Z400 E5000					; set accelerations (mm/s^2)
M906 X1680 Y1680 Z1330 E1000 I30			; set motor currents (mA) and motor idle factor in per cent
M84 S30										; Set idle timeout

; Axis Limits
M208 X0 Y0 Z0 S1			; set axis minima
M208 X160 Y180 Z200 S0		; set axis maxima

; Endstops
M574 X2 S3					; configure sensorless homing for high end of x
M574 Y2 S3					; configure sensorless homing for high end of Y
M574 Z1 S2					; configure Z-probe endstop for low end on Z

; Z-Probe
M558 P8 C"^25.io2.in" H2.5 F360 T40000 R1	; Set Z probe type to NC switch and the dive height + speeds
G31 P500 X13 Y-29 Z4.03						; set Z probe trigger value, offset and trigger height, -z separates from bed, +z brings nozzle tip closer
M557 X14:165 Y13:147 P2						; define mesh grid

; Bed Heater
M308 S0 P"temp2" Y"thermistor" T100000 B3950		; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out0" T0									; create bed heater output on out0 and map it to sensor 0
M307 H0 R0.604 K0.361:0.000 D5.92 E1.35 S1.00 B0	; 180mm bed, 170mm pad, 180w, 24v DC bed, 80c (fysetc)
M140 H0												; map heated bed to heater 0
M143 H0 S100										; set temperature limit for heater 0 to 150C

; Nozzle Heater
M308 S1 P"25.temp0" Y"pt1000"							; configure sensor 1 as pt1000 on pin temp0
M950 H1 C"25.out0" T1									; create nozzle heater output on out0 and map it to sensor 1
M307 H1 R3.362 K0.248:0.115 D6.24 E1.35 S1.00 B0 V24.1	; revo HT, 65w heater, 285c, 20w air pump
M143 H1 S400											; limit nozzle to 400c

; Part Cooling
M950 F0 C"out4" Q30				; create fan 0 on pin out4 and set its frequency
M106 P0 S0 H-1					; set fan 0 value. Thermostatic control is turned off

; Heatbreak Cooling
M950 F1 C"25.out2"				; create fan 1 on pin 25.out2 and set its frequency
M106 P1 H1 T80					; set fan 1 value. Thermostatic control is coupled with nozzle temperature

; Duet Board Cooling
M950 F3 C"out3" Q20000			; create fan 3 on pin out3 and set its frequency
M106 P3 H1 T80					; set fan 3 value. Thermostatic control is coupled with nozzle temperature, active printing implies controller board heat

; Define extruder
M563 P0 D0 H1 F0				; define tool 0
G10 P0 X0 Y0 Z0					; set tool 0 axis offsets
G10 P0 R0 S0					; set initial tool 0 active and standby temperatures to 0C

; enable 12864 LCD, configure LEDs
M918 P2 E4 F2000000
m150 x4 r255 u255 b255 p255