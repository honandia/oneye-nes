;macro to set a pointer to a 16 bit address stored into two separate bytes
;input - (address, store_hi, store_lo)
SET_POINTER_TO_ADDR .macro
    LDA #HIGH(\1)                   ;gets the high byte of the specified address
    STA \2                          ;store in store_hi
    LDA #LOW(\1)                    ;gets the low byte of the specified address
    STA \3                          ;store in store_lo

    .endm