/***************NOTEPAD++ TO KEEP TRACK OF WIRE NAMING (LIFE SAVER)*********/
module Seventy_Two_Bit_Processor_Top;

/***************************************************************************/
/************************Wire Instantiate***********************************/
/***************************************************************************/
  //Global Wires
  wire clk, rst;
  //Wires from Control Unit
  wire Branch_en, Jump_en, immediate_en, write_reg, write_datamem;

  //Wires from Instruction Fetch
  wire [71:0] Instruction_Fetch;
  //Wires from Program Counter
  wire [71:0] PC_out

  //Wires from Register

  //Wires from ALU

  //Wires from Multiplexers
  wire [71:0] immediate_mux_out, concatination_out;

  /**************************************************************************************/
/************************Program Counter Instantiate***********************************/
/**************************************************************************************/

  /*
    ProgramCounter PC(
      .clk(clk)
      .rst(reset),
      .PC_in(PC_out)
      .jump_address(Instruction_Fetch),    //jump_address will grab respective immediate address [54:0] of instruction fetch 
      .branch_address(Instruction_Fetch),  //branch_address will grab respective immediate address [67:0] of instruction fetch
      .Jump_en(Jump_en)
    );


    AND uut(Branch_en, Branch_op[0], AND_Result);
  */

    /***************************************************************************/
/************************Instruction Fetch Instantiate***********************************/
/***************************************************************************/

  /*
  InstructionFetch IF(
      .clk(clk),
      .reset(rst),
      .address(PC_out),
      .instruction(Instruction_Fetch)
  );

  */


  /**************************************************************************************/
 /************************REGISTER Instantiate***********************************************/
/**************************************************************************************/

  Register register(
    .write(write_reg),
    .clk(clk),
    .reset(rst),
    .reg1_address(Instruction_Fetch[67:62]),
    .reg2_address(Instruction_Fetch[61:55]),
    .reg_r_address(Instruction_Fetch[54:48])
  );
  
  /**************************************************************************************/
 /************************ALU Instantiate***********************************************/
/**************************************************************************************/

  /*
  ALU alu(
    .write(write_reg),
    .clk(clk),
    .op(Instruction_Fetch),
    .
  );
  */
  
  
endmodule
