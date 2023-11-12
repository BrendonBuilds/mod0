; homez.g
; called to home the Z axis

M400				; finish all moves

G91               	; relative positioning
G1 H2 Z2.5 F1800	; lift z
G90					; absolute positioning

G1 X1 Y42 F30000	; go to first G29 location

G30					; probe single point
