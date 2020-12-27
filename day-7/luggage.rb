class Node
  attr_accessor :name, :children, :parents

  def initialize(name="")
    @name = name
    @children = Hash.new
    @parents = Hash.new
  end

  def add_child(child, amount)
    @children[child] = amount
  end

  def add_parent(parent)
    @parents[parent.name] = parent
  end
end

def read_file 
  nodes = Hash.new

  File.foreach("input.txt") { |line|
    parent = nil

    captures = line.scan(/(\d*) *(\S+ \S+) bags?/)

    if parent == nil 
      name = captures[0][1]
      if nodes.key?(name)
        parent = nodes[name]
      else
        parent = Node.new(name)
        nodes[parent.name] = parent
      end
    end

    captures[1..-1].each { |capture|
      count = capture[0]
      name = capture[1]
      child = nil

      if nodes.key?(name)
        child = nodes[name]
      else
        child = Node.new(name)
        nodes[child.name] = child
      end

      parent.add_child(child, count)
      child.add_parent(parent)
    }
  }

  puts find_children(nodes["shiny gold"], 1, 0)
end

def find_parents(nodes, name, parents)
  if !nodes.key?(name)
    print "No node found, ", name
    print
    return
  end

  node = nodes[name]
  node.parents.each  { |name, node|
    parents[name] = node
    find_parents(nodes, name, parents)
  }
end

def find_children(parent, multiplier=1, total=0)
  parent.children.each { |child, count|
    newmul = multiplier * count.to_i
    total += newmul
    if child.children != nil
      total = find_children(child, newmul, total)
    end
  }

  return total
end

read_file