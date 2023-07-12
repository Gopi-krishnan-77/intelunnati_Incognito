module fast (
  input signed [3:0] dividend,
  input signed [3:0] divisor,
  output signed [3:0] quotient,
  output signed [3:0] remainder
);

  reg signed [3:0] dividend_abs;
  reg signed [32:0] divisor_abs; 
  reg signed [3:0] quotient_temp;
  reg signed [3:0] remainder_temp;
  reg signed [4:0] reciprocal; 
  reg signed [2:0] i;
  reg signed [3:0] quotient_reg;
  reg signed [3:0] remainder_reg;

  always @* begin
    dividend_abs = (dividend < 0) ? -dividend : dividend;
    divisor_abs = (divisor < 0) ? -divisor : divisor;

    reciprocal = 9'd0; 
    quotient_temp = 8'd0;
    remainder_temp = dividend_abs;

    reciprocal = reciprocal + (divisor_abs << 0);
    quotient_temp = quotient_temp << 1;
    if (remainder_temp >= reciprocal) begin
      remainder_temp = remainder_temp - reciprocal;
      quotient_temp[0] = 1;
    end

    reciprocal = reciprocal + (divisor_abs << 1);
    quotient_temp = quotient_temp << 1;
    if (remainder_temp >= reciprocal) begin
      remainder_temp = remainder_temp - reciprocal;
      quotient_temp[0] = 1;
    end
    reciprocal = reciprocal + (divisor_abs << 7);
    quotient_temp = quotient_temp << 1;
    if (remainder_temp >= reciprocal) begin
      remainder_temp = remainder_temp - reciprocal;
      quotient_temp[0] = 1;
    end

    if (dividend < 0) begin
      quotient_reg = -quotient_temp;
      remainder_reg = -remainder_temp;
    end
    else begin
      quotient_reg = quotient_temp;
      remainder_reg = remainder_temp;
    end
  end

  assign quotient = quotient_reg;
  assign remainder = remainder_reg;

endmodule