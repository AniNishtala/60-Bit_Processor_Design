import random

# Function to generate a random binary string of a specific width
def generate_random_binary(width):
    return ''.join(random.choice('01') for _ in range(width))

# Function to generate an R-type instruction
def generate_r_type():
    opcode = "0000"  #  opcode for R-type
    rs = generate_random_binary(6)  # Random source register
    rt = generate_random_binary(6)  # Random target register
    rd = generate_random_binary(6)  # Random destination register
    shamt = generate_random_binary(6)  # Random shift amount
    func = generate_random_binary(6)  # Random function code
    unused = "0" * 38  # Remaining bits for 72-bit alignment
    return opcode + rs + rt + rd + shamt + func + unused

# Function to generate an I-type instruction
def generate_i_type():
    opcode = "0001"  #  opcode for I-type
    rs = generate_random_binary(6)  # Random source register
    rt = generate_random_binary(6)  # Random target register
    immediate = generate_random_binary(16)  # Random immediate value
    unused = "0" * 40  # Remaining bits for 72-bit alignment
    return opcode + rs + rt + immediate + unused

# Function to generate a J-type instruction
def generate_j_type():
    opcode = "0010"  #  opcode for J-type
    address = generate_random_binary(26)  # Random jump address
    unused = "0" * 42  # Remaining bits for 72-bit alignment
    return opcode + address + unused

# Generate 10 instructions, including at least 1 R-type, 1 I-type, and 1 J-type
instructions = [generate_r_type(), generate_i_type(), generate_j_type()]
for _ in range(7):  # Fill the rest with random R, I, or J instructions
    instruction_type = random.choice(['R', 'I', 'J'])
    if instruction_type == 'R':
        instructions.append(generate_r_type())
    elif instruction_type == 'I':
        instructions.append(generate_i_type())
    else:
        instructions.append(generate_j_type())

# Shuffle the instructions to randomize their order
random.shuffle(instructions)

# Write the instructions to a file
output_file = "machinecode.txt"
with open(output_file, "w") as file:
    file.write("\n".join(instructions))

print(f"Generated 10 lines of 72-bit machine code and saved to {output_file}")
