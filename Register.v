module Register(
	/**************************************************************************/
	/*Might have to change data width with respect to ptoential future changes*/
	/**************************************************************************/
	input write, clk,
	input [6-1: 0] reg1_address, reg2_address, reg_r_address,
	input [72-1:0] result_in,	
	output reg [72-1:0] data_out1, data_out2
);

parameter n = 72; //data width
parameter d = 6; //data address width

/*Need a way to access memory file here*/
reg [n-1:0] datamemory [0:d-1]; 
/***************************************/


always @(posedge clk) begin
	if(write) begin //If we are writing result 
	datamemory[reg_r_address] <= result_in; //writing result in from ALU op into destination register address
	end
	else begin //else we are reading reg from memory and outputting into ALU
	data_out1 <= datamemory[reg1_address];
	data_out2 <= datamemory[reg2_address];
	end 
end 
endmodule
