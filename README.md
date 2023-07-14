# Design and Implementation of Slow and Fast Division Algorithms in Computer Architecture


## Description
A division algorithm is a mathematical process that calculates the quotient and/or remainder of two integers, given a dividend and divisor. For example, if the dividend (a) is 15 and the divisor (b) is 8, the quotient (q) is 1 and the remainder (r) is 7. This project aims to implement both slow and fast division algorithms to perform such calculations efficiently.

## Contents
 - ``Flow Chart``
 - ``Algorithm``
 - ``Verilog Code & Test Bench``
 - ``RTL Simulation``
 - ``Functional Simulation``
 - ``Pin Planning``
 - ``Synthesis``
 - ``Analyzation of Area, Power & Speed``
 - ``Implementation in Cyclone V FPGA Board - 5CSEMA5F31C6``
 - ``Video Demo``

## Slow Division
1. The module waits in the IDLE state until the start signal (start) becomes active.
2. When the start signal is active, the dividend (X) is loaded into a temporary register (Z) with its upper 4 bits set to zero.
3. The division algorithm enters the START state and performs the division operation.
4. In each clock cycle, the algorithm shifts the temporary register left by 1 bit (Z_temp).
5. The lower 4 bits of Z_temp are subtracted from the upper 4 bits, and the result is stored in Z_temp1.
6. The next value of Z (next_Z) depends on the sign bit of Z_temp1. If the sign bit is 1, next_Z includes the upper 4 bits of Z_temp followed by the lower 3 bits of Z_temp and a 0 bit. Otherwise, next_Z includes the upper 4 bits of Z_temp1 followed by the lower 3 bits of Z_temp and a 1 bit.
7. The count (number of iterations) increments by 1 in each clock cycle.
8. The valid signal becomes active when the count is non-zero, indicating that the division operation is complete.
9. If the count is non-zero, the algorithm transitions back to the IDLE state; otherwise, it remains in the START state to continue the division operation.

## Fast Divison
1. The absolute values of the dividend and divisor are calculated and stored in dividend_abs and divisor_abs registers, respectively.
2. The reciprocal register is initialized to zero.
3. The quotient_temp register is initialized to zero, and the remainder_temp register is initialized with the value of the absolute dividend.
4. The algorithm performs three iterations to calculate the quotient and remainder:
  - In each iteration, the reciprocal register is updated by shifting the absolute divisor by a different amount (0, 1, or 7 bits left).
  - The quotient_temp register is shifted left by one bit in each iteration.-
  - If the remainder_temp is greater than or equal to the reciprocal value, it subtracts the reciprocal from the remainder_temp and sets the least significant bit of quotient_temp to 1.
5. After the three iterations, the algorithm checks the sign of the original dividend:
 -  If the dividend is negative, the quotient_reg and remainder_reg registers are set to the negation of quotient_temp and remainder_temp, respectively.
 -  If the dividend is positive, the quotient_reg and remainder_reg registers are set to the values of quotient_temp and remainder_temp, respectively.
6. The final values of quotient_reg and remainder_reg are assigned to the output signals quotient and remainder, respectively, using assigned statements.

## Tools Used
Intel® Quartus® Prime Lite Software and ModelSim Altera for Simulation
LabsLand Online Virtual Laboratory Setup
