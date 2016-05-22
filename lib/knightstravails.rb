require_relative '00_tree_node'

class KnightPathFinder
  DIRECTIONS = [ [-1,-2], [-1,2], [1,-2], [1,2], [-2,-1], [-2,1], [2,-1], [2,1] ]

  def initialize(root_val)
    @root_val = root_val
    @visited_positions = [root_val]
    build_move_tree
  end

  def new_move_positions(pos)
    all_valid_moves = self.class.valid_moves(pos)
    new_valid_moves = all_valid_moves.reject { |move| @visited_positions.include?(move)}
    @visited_positions += new_valid_moves
    new_valid_moves
  end

  def self.valid_moves(pos)
    moves = []
    x, y = pos
    DIRECTIONS.each do |direction|
      a, b = direction
      new_pos = [x + a, y + b]
      if new_pos.all? { |coord| coord.between?(0, 7)}
        moves << [x + a, y + b]
      end
    end
    moves
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@root_val)
    queue = [@root_node]

    until queue.empty?
      curr_node = queue.shift
      new_children_vals = new_move_positions(curr_node.value)
      new_children_vals.each do |child_val|
        child_node = PolyTreeNode.new(child_val)
        child_node.parent = curr_node
        queue << child_node
      end
    end
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = [end_node.value]

    curr_node = end_node
    until curr_node.parent.nil?
      path.unshift(curr_node.parent.value)
      curr_node = curr_node.parent
    end
    p path
  end
end

if __FILE__ = $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  kpf.find_path([6, 2])
end
