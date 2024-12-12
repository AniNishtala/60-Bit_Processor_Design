/***************NOTEPAD++ TO KEEP TRACK OF WIRE NAMING (LIFE SAVER)*********/
module Seventy_Two_Bit_Processor_Top(

input wire clk, rst
);

/***************************************************************************/
/************************Wire Instantiate***********************************/
/***************************************************************************/

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
/************************Program Counter Instantiate***********************************/
/**************************************************************************************/

  
ProgramCounter PC(
    .clk(clk),
    .rst(rst),                        // Corrected to match the port name 'rst'
    .Branch(AND_result),              // Correct 'Branch' signal connected to the AND gate output
    .jump(Jump_en),                   // 'jump' signal connected to Jump_en
    .Addr(PC_out),                    // Target address (PC output)
    .jump_addr(Instruction_Fetch[67:0]),  // Jump address from instruction fetch (Instruction_Fetch[67:0])
    .branch_addr(Instruction_Fetch[54:0]), // Branch address from instruction fetch (Instruction_Fetch[54:0])
    .PC(PC_out)                       // Program counter output (PC)
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
	.A(data_out1),
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
    .reset(rst),                             // 'rst' is the signal name in your top module
    .write_enable(write_en),                 // 'write_en' signal from your control logic
    .register_destination_address(Instruction_Fetch[55:50]),  // Corrected to use 'register_destination_address'
    .ALU_Result(ALU_out)                     // 'ALU_out' is the result from the ALU
);




endmodule
