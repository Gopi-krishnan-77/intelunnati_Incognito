module fast_tb;

  
  reg [3:0] dividend;
  reg [3:0] divisor;

 
  wire [3:0] quotient;
  wire [3:0] remainder;

  
  fast uut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  
  reg clk;

  
  initial begin
    clk = 0;
    dividend = 10;
    divisor = 2;

    #5; 
    dividend = 12;
    divisor = 4;

    #10; 
    dividend = 11;
    divisor = 5;
    #15;
    $finish; 
  end

  
  always begin
    #5; 
    clk = ~clk;
  end

endmodule
