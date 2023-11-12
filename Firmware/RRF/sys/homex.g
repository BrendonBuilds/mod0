; homex.g
; called to home the X axis

M400					; allow all prior moves to finish
G91						; relative positioning

G1 H1 X1 Z2.5 F1800		; raise nozzle, energize x/y motors

M400					; allow prior moves to finish

M566 X200 Y200			; reduce jerk values

M913 X20 Y20			; set motor current to 20%, may need to be increased for some steppers to prevent early stalls

M915 H400 X Y S2 R0 F0	; configure sensorless homing parameters, some motors may simply 'crash' at the limit

G1 H1 x200 F5000		; move quickly to X axis endstop and stop there, may rattle if stall detection isn't working
G1 H1 x-5 F30000		; move away from limit

G1 H1 Z-2.5				; lower nozzle

G90               		; absolute positioning
G92 x155				; set to axis maxmia (minus clearance)

M913 x100 Y100			; return motor current to 100%

M566 X1100 Y1100		; return jerk values