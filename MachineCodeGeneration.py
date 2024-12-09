import random

# Function to generate a random 72-bit binary string
def generate_72bit_code():
    return ''.join(random.choice('01') for _ in range(72))

# Generate 100 lines of 72-bit machine code
lines = [generate_72bit_code() for _ in range(100)]

# Write the generated code to a file
output_file = "machinecode.txt"
with open(output_file, "w") as file:
    file.write("\n".join(lines))

print(f"Generated 100 lines of 72-bit machine code and saved to {output_file}")
