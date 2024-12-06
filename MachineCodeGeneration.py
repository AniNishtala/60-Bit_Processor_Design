import random

def generate_machine_code(file_name, num_instructions):
    # Opcodes for the processor
    opcodes = {
        0: "C = A + B",       # add
        1: "C = A - B",       # sub
        2: "C = A * B",       # mul
        3: "C = A / B",       # div
        4: "C = A << B",      # LSL by B
        5: "C = A >> B",      # LSR by B
        6: "C = A + B[54:0]", # addi
        7: "C = A - B[54:0]", # subi
        8: "C = A & B[54:0]", # andi
        9: "C = A && B",      # and logical operation
        10: "C = A || B",     # or logical operation
        11: "C = A ^ B",      # xor operation
        12: "C = (A == B) ? 72'b1 : 72'b0", # beq
        13: "C = (A != B) ? 72'b1: 72'b0",  # bne
        14: "C = (A < B) ? 72'b1: 72'b0",   # blt
        15: "C = (A > B) ? 72'b1: 72'b0",   # bgt
    }

    # Ensure each opcode appears at least once
    instructions = list(opcodes.keys())
    additional_instructions_needed = num_instructions - len(instructions)
    if additional_instructions_needed > 0:
        instructions.extend(random.choices(list(opcodes.keys()), k=additional_instructions_needed))

    # Write machine code to file
    with open(file_name, "w") as file:
        for opcode in instructions:
            A = random.choice(["0", "1"]) * 72  # Random 72-bit binary string of 0 or 1
            B = random.choice(["0", "1"]) * 72  # Random 72-bit binary string of 0 or 1
            machine_code = f"{opcode:04b}{A}{B}"  # Remove underscores for raw machine code
            file.write(machine_code + "\n")

# User input for number of instructions
num_instructions = int(input("Enter the number of instructions to generate: "))
generate_machine_code("machinecode.txt", num_instructions)

print(f"Generated {num_instructions} instructions in 'machinecode.txt'.")
