class Instruction
  attr_accessor :kind, :value, :visited

  def initialize(kind="", value=0)
    @kind = kind
    @value = value
    @visited = false
  end
end

def read_instructions
  instructions = []

  File.foreach("input.txt") { |line|
    captures = line.scan(/(nop|acc|jmp) ((\+|-)\d+)/)
    kind = captures[0][0]
    value = captures[0][1].to_i

    instructions << Instruction.new(kind, value)
  }

  return instructions
end

def process_instructions(instructions, change=0)
  loc = 0
  acc = 0
  encountered = 0
  terminated = false
  while loc < instructions.length
    instruction = instructions[loc]
    if instruction.visited
      terminated = true
      break
    end

    case instruction.kind
    when "acc"
      acc += instruction.value
      loc += 1
      instruction.visited = true

    when "jmp", "nop"
      encountered += 1
      instr_copy = instruction.kind.clone

      if encountered == change
        if instr_copy == "jmp"
          instr_copy = "nop"
        else
          instr_copy = "jmp"
        end
      end

      case instr_copy
      when "jmp"
        loc += instruction.value
        instruction.visited = true
      when "nop"
        loc += 1
        instruction.visited = true
      end

    end
  end

  return acc, terminated
end

def find_correct_process
  instructions = read_instructions

  i = 0
  terminated = true
  acc = 0
  while terminated
    instructions.each { |instruction|
      instruction.visited = false
    }

    acc, terminated = process_instructions(instructions, i)
    i += 1
  end

  puts acc
end

find_correct_process