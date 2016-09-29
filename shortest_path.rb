# Simple program to find shortest route and distance between 2 given points
class Graph
  def initialize
    @edges = []
    @visited = {}
  end

  def addEdge(from, to, distance)
    edges << [from, to, distance]
    edges << [to, from, distance]
  end

  attr_accessor :edges, :visited

  def shortest_path(src, dst)
    dijkstra(src, dst)
    shortest_distance = visited[dst][0]
    path = []
    path << dst
    prev_node = dst
    while !path.include?(src)
      prev_node = @visited[prev_node][1]
      path << prev_node
    end
    result = "Shortest route and distance: #{path.reverse.join('-')}, #{shortest_distance} km"
    puts "#{result}"
    result
  end

  def dijkstra(src, dst)
    all_nodes = edges.map{|item| [item[0], item[1]]}.flatten.uniq
    n = all_nodes.count
    previous = {}
    present = {src => [0, src]}
    distances = Hash[edges.map{|item| [[item[0], item[1]], item[2]]}]

    n.times.each do |i|
      @visited.merge!(present)
      p = present.keys.first
      weight = present.values.first[0]
      current = {}
      all_nodes.each do |node|
        next if visited.keys.include?(node)
        if edges.map{|item| [item[0], item[1]]}.include?([p, node])
          distance = weight + distances[[p, node]]
          current[node] = (previous[node] && !previous[node].empty? && previous[node][0] < distance) ? previous[node] : [distance, p]
        else
          current[node] = previous[node] || []
        end
      end
      break if current.empty?
      min = current.values.map(&:first).compact.min
      present = current.select{|k,v| v[0] == min}
      previous = current
    end
  end
end

g = Graph.new

g.addEdge('A', 'B', 24)
g.addEdge('A', 'C', 71)
g.addEdge('B', 'D', 59)
g.addEdge('E', 'F', 141)
g.addEdge('E', 'C', 101)
g.addEdge('B', 'G', 103)
g.addEdge('E', 'D', 65)
g.addEdge('F', 'C', 169)
g.addEdge('C', 'D', 134)

g.shortest_path('F', 'G')
