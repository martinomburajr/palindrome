#OMBMAR001

.data
isPalinMess: .asciiz   "It is a palindrome \n"
noPalinMess: .asciiz   "It is not a palindrome \n"
startMess:  .asciiz     "Enter a number: \n"
temp1:   .word       0    # entered number
decima: .word 10 #decima

.text
main:

#START MESSAGE
    la $a0,startMess 
    li $v0, 4
    syscall

#ENTER NUMBER
    li $v0, 5
    syscall
    sw $v0, temp1    #SWAP NUMBER TO MEMORY
    
    
    ################################ SETUP ########################

    move $v1, $v0 #move v0 to v1
    move $t2, $zero       # set t2 = 0
    lw $t3, decima         # set t3 = 10
    move $t0, $zero      #  set t0 = 0

    move $t4, $v1       # copy of int1

    jal reverse

    j end


#######################REVERSE: REVERSES PALINDROME#######################################
reverse:    #reverse the number
    bgtz $t4, reverseFunction   # while 0 < int1 (in $t4) do reverse step
    j compare


################# REVERSEFUNCTION: REVERSES THE INTEGER #########################
reverseFunction:
    div $t4, $t3        # no/10
    mfhi $t6        # temp variable for mod rest
    mult $t2, $t3       # rev * 10
    mflo $t2        # temp variable for mult result
    add $t2, $t2, $t6   # rev + mod
    div $t4, $t3        # divide int1 copy by 10
    mflo $t4        # temp value for t4

    j reverse

########### COMPARE: COMPARES THE TWO INTEGERS ########################
compare:
    beq $t2, $v1, pal
    j nopal

############### PAL : IF PALINDROME PRINT MESSAGE #####################
pal:
    la $a0, isPalinMess    # load is palindrome message
    li $v0, 4
    syscall
    j end

############### IF NOT PALINDROME: PRINT MESSAGE ###############################
nopal:
    la $a0, noPalinMess    # load no palindrome message
    li $v0, 4
    syscall 
    j end

end:
	li $v0,10
	syscall #Exit