; PIC16F84A Configuration Bit Settings
; Assembly source line config statements
#include <xc.inc>
; CONFIG
  CONFIG  FOSC = HS             ; Oscillator Selection bits (HS oscillator)
  CONFIG  WDTE = OFF            ; Watchdog Timer (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (Power-up Timer is disabled)
  CONFIG  CP = OFF              ; Code Protection bit (Code protection disabled)
PSECT Por_Vec,global,class=CODE,delta=2
TEMP EQU 0x00
INICIO:
    ; Configuración de puertos
    bsf  RP0     ; Seleccionar banco 1
    movlw 0xFF          ; Configurar RB6 y RB7 como entradas, el resto como salidas
    movwf TRISB
    movlw 0x00          ; Configurar RA0 como salida, el resto como entradas
    movwf TRISA
    bcf  RP0     ; Seleccionar banco 0

    ; Inicialización de variables
    clrf PORTA          ; Apagar todos los LEDs

PRINCIPAL:
    btfsc PORTB, 6   
    movlw 0x01
    btfss PORTB, 6     
    movlw 0x00
    movwf TEMP
    btfsc PORTB, 7 
    call CAMBIAR_ESTADO
    MOVWF PORTA
    call PRINCIPAL   
    return

CAMBIAR_ESTADO:
    ; Cambiar el estado del LED en RA0
    btfsc TEMP, 0      ; Verificar el estado actual del LED
    movlw 0x00
    btfss TEMP, 0      ; Verificar el estado actual del LED
    movlw 0x01
    return
END