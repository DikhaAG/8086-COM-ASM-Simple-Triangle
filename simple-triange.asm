.model small
.code
org 100h
tdata:  
    jmp proses
    star db '*$'
    space db ' $'
    new_line db 13, 10, '$'    
proses:  
    mov  ah, 0x9        
    push dx
    mov  bl, 8           ;how much the row should be
    mov  cl, 0
    mov  bh, 1
    mov  ch, 0
write_col:
    cmp  cl, bl          
    jge  write_star      
    lea  dx, space       
    int  0x21            
    add  cl, 1           
    jmp  write_col              
write_star:
    cmp  ch, bh
    jge  write_row
    lea  dx, star
    int  0x21
    add  ch, 1
    jmp  write_star    
write_row:
    add  bh, 2
    xor  ch,ch
    cmp  bl, 0           
    jz   exit            
    lea  dx, new_line    
    int  0x21            
    add  bl, -1          
    xor  cl, cl          
    jmp  write_col              
exit: 
    pop dx
    int  0x20            
end tdata
