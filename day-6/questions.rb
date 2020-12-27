class Group
  attr_accessor :questions, :people

  def initialize(questions, num_people)
    @questions = questions
    @people    = num_people
  end

  def find_consensus
    total = 0
    questions.each { |question, num| 
      if num == @people
        total += 1
      end
    }

    return total
  end
end

def sum_questions
  groups = []

  questions = Hash.new
  num_people = 0
  File.foreach("input.txt") { |line| 
    if line == "\n"
      groups << Group.new(questions, num_people)
      questions = Hash.new
      num_people = 0
      next
    end

    num_people += 1
    line.strip.each_char { |c|
      if questions.key?(c)
        questions[c] += 1
      else 
        questions[c] = 1
      end
    }
  }

  groups << Group.new(questions, num_people)
  questions = Hash.new
  num_people = 0

  sum = 0
  groups.each { |group|
    sum = sum + group.find_consensus
  }

  puts sum
end

sum_questions