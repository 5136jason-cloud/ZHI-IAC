// Design Name : bin2bcd
// File Name : bin2bcd.v
// Function : convert 8-bit binary number in to three BCD digits
// Author:  Peter Cheung
// Version: 2.0 (26 Aug 2022)
//---------------------------------------------------
//ALGORITHM: (See explanation on course webpage)
//   Shift binary number x left by one bit at a time into temporary register 'result'
//   If bottom 4 bits of result  >= 5
//		add 3 (only once)
//   Continue shifting x into result until all bit in x have been processed


module bin2bcd (
	input  logic [7:0]   x,			// value ot be converted
	output logic [11:0]  BCD     // BCD digits
);	
	 // Concatenation of input and output
   logic  [19:0] result;  // no of bits = no_of_bit of x + 4* no of digits
   integer i;
   
   always_comb
   begin
      result[19:0] = 0;
      result[7:0] = x;     // bottom 8 bits has input value

      for (i=0; i<8; i=i+1) begin
			// Check if unit digit >= 5
         if (result[11:8] >= 5)
            result[11:8] = result[11:8] + 4'd3;
				
         // Check if ten digit >= 5
         if (result[15:12] >= 5)
            result[15:12] = result[15:12] + 4'd3;

			// Shift everything left
         result = result << 1;
      end
      
      // Decode output from result
      BCD = result[19:8];
   end
	
endmodule
