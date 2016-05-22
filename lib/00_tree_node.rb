class PolyTreeNode
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    if !@parent.nil?
      @parent.children.delete(self)
    end
    @parent = parent_node
    if !parent_node.nil? && !parent_node.children.include?(self)
      parent_node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Tried to remove node that isn't a child" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def bfs(target_value)
    @queue = [self]
    until @queue.empty?
      curr_node = @queue.shift
      return curr_node if curr_node.value == target_value
      @queue.concat(curr_node.children)
    end

    nil
  end

  # def dfs(target_value)
  #   @stack = [self]
  #
  #   while !@stack.empty?
  #     curr_node = @stack.pop
  #     if curr_node.value == target_value
  #       return curr_node
  #     end
  #     @stack.concat(curr_node.children)
  #   end
  #
  #   nil
  # end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      res = child.dfs(target_value)
      next if res.nil?
      return res
    end

    return nil
  end
end
