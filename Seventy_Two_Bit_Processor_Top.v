`timescale 1ps/ 1ps
/***************NOTEPAD++ TO KEEP TRACK OF WIRE NAMING (LIFE SAVER)*********/
module Seventy_Two_Bit_Processor_Top;

/***************************************************************************/
/************************Wire Instantiate***********************************/
/***************************************************************************/
  
  //Input Reg Signals to control our entire processor
  reg [71:0] PC_in;
  reg clk, rst;
 
  // Clock generation
  always begin
    #50 clk = ~clk;  // 10ns clock period
  end
   
  initial begin
    clk = 0; 
    rst = 0; 
    PC_in = 71'b0;
  end
  
  //Wires from Control Unit
  wire Branch_en, Jump_en, immediate_en, write_en, write_datamem;
  

  //Wires from Instruction Fetch
  wire [71:0] Instruction_Fetch;
 
  //Wires from Program Counter
  wire [71:0] PC_out;
  wire AND_result;
  
  
  
  //Wires from Register and ALU
  wire[71:0] data_out1, data_out2, ALU_out; //wires for reading source registers data
  //Wires from Multiplexer to choose between immediate and r type input b
  wire [71:0] immediate_mux_out, concatinator_out;

  /**************************************************************************************/
/************************Testbench Here?***********************************/
/**************************************************************************************/

  /**************************************************************************************/
/************************Program Counter Instantiate***********************************/
/**************************************************************************************/

  
    ProgramCounter PC(
      .clk(clk),
      .rst(rst),
      .Branch(AND_result), //AND_Result is the Branch_end ANDed with teh ALU output bit postion 0
      .jump(Jump_en),
      .Addr(PC_in),
      .jump_addr(Instruction_Fetch[67:0]),    //jump_address will grab respective immediate address for jump[54:0] of instruction fetch 
      .branch_addr(Instruction_Fetch[54:0]),  //branch_address will grab respective immediate address for branch[67:0] of instruction fetch
      .PC(PC_out)
	);

   //AND gate tthat takes in teh branch_en signal and the LSB of ALU_out where the ALU_out will be 1 is the branch operation from ALU op code is true
   //The branch_en comes from the control unit to check if it is actually a BRANCH operation along with checking if true from the ALU_out.
  
    and (AND_result, Branch_en, ALU_out[0]);


/****************************************************************************************/
/************************Instruction Fetch Instantiate***********************************/
/****************************************************************************************/

 
  InstructionFetch IF(
      .clk(clk),
      .reset(rst),
      .address(PC_out),
      .instruction(Instruction_Fetch)
  );

 //Instruction_Fetch_reg = Instruction_Fetch;


  /**************************************************************************************/
 /************************REGISTER Instantiate***********************************************/
/**************************************************************************************/



  Register register(
    .clk(clk),
    .reset(rst),
    .reg1_address(Instruction_Fetch[67:62]),
    .reg2_address(Instruction_Fetch[61:56]),
    .data_out1(data_out1),
    .data_out2(data_out2)
  );
 
  
  
  /**************************************************************************************/
 /************************Control Unit Instantiate***********************************************/
/**************************************************************************************/


  Control_Unit controlunit(
	.clk(clk),
	.opcode(Instruction_Fetch[71:68]),
	.branch_en(Branch_en),
	.jump_en(Jump_en),
	.immediate_en(immediate_en),
	.write_en(write_en)
  );


  /**************************************************************************************/
 /************************ALU Instantiate***********************************************/
/**************************************************************************************/

  //Concatinate immediate number to 72 bits for the ALU
  Concatinator concat(
	.A(Instruction_Fetch[49:0]),
        .B(concatinator_out)
	);

//Multiplexer for choosing the B input of the ALU to be either the regular Rb data (R-type) or immediate value (I-Type)
  Multiplexer21 mux(
	.A(data_out2),
	.B(concatinator_out),
	.selectionLine(immediate_en),
	.C(immediate_mux_out)
	);


  
  ALU alu(
    .clk(clk),
    .op(Instruction_Fetch[71:68]),
    .A(data_out1),
    .B(immediate_mux_out),
    .C(ALU_out)
  );
  
  

  /**************************************************************************************/
 /************************Data Memory Instantiate***********************************************/
/**************************************************************************************/
  


   Data_Memory datamemory(
	.clk(clk),
	.reset(rst),
	.write_enable(write_en),
	.register_destination_address(Instruction_Fetch[55:50]),
	.ALU_Result(ALU_out)
   );



endmodule
