# Define the memory size and content
num_lines = 128  # 0x3FF locations
file_name = "data_mem.txt"

# Open the file for writing
with open(file_name, "w") as file:
    for i in range(num_lines):
        # Format the number in hexadecimal and pad to ensure it's a 72-bit value
        # Hexadecimal representation of a 72-bit wide value
        hex_value = f"{i:018X}"  # Format as a hexadecimal string with 72 bits (18 hex digits)
        file.write(hex_value + "\n")

print(f"File '{file_name}' created with {num_lines} lines of 72-bit incremented values in hexadecimal.")
