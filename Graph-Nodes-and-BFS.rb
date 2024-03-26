class GraphNode
 attr_accessor :value, :neighbors

    def initialize(value)
        @value = value
        @neighbors = []
    end

    def add_neighbor(node)
        @neighbors << node
    end

    def bfs(starting_node, target_value)
        que = [starting_node]
        visited = []

        until que.empty?
            current_node = que.shift
            if current_node.value == target_value
                return current_node
            end

            visited << current_node
            current_node.neighbors.each do |neighbor|
                que << neighbor unless visited.include?(neighbor)
            end
    end

    return nil
end

    a = GraphNode.new('a')
    b = GraphNode.new('b')
    c = GraphNode.new('c')
    d = GraphNode.new('d')
    e = GraphNode.new('e')
    f = GraphNode.new('f')
    a.neighbors = [b, c, e]
    c.neighbors = [b, d]
    e.neighbors = [a]
    f.neighbors = [e]
end