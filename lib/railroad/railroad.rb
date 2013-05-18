class Railroad

  def self.map(*routes)
    @map ||= RouteMap.build_map(routes)
  end

  def self.distance(*towns)
    distance = 0
    towns_in_route = towns.collect { |town| Town.find(town) }
    towns_in_route.each_with_index do |current_town, index|
      next_town = towns_in_route[index + 1]
      if current_town.connected_to?(next_town)
        distance += current_town.distance_to(next_town) if (next_town != nil)
      else
        distance += calculate_route(current_town, next_town)
      end
    end
    distance
  end

  def self.max_by_miles(starting_town, ending_town, distance)
    available_routes = all_routes(starting_town, ending_town)
    
  end

  def self.all_routes(starting_town, ending_town)
    r = []
    nodes = []
    starting_town = Town.find(starting_town)
    starting_town.routes.each do |route|
      r << starting_town.name + route.end_point
      nodes << Town.find(route.end_point)
    end
    while !( nodes.all? { |node| node.name == ending_town })
      r = nodes.collect { |town| expand(town, r.flatten) }.flatten
      end_routes = nodes.collect { |node| node.routes }
      new_nodes = end_routes.flatten.collect { |route| route.end_point }
      nodes.clear
      nodes = new_nodes.collect { |node| Town.find(node) }
      nodes = nodes.select { |node| node.name != ending_town }
    end
    puts r.uniq.inspect
  end

  def self.expand(town, nodes)
    final_routes = nodes
    nodes.flatten.each do |node|
      a = node.split("")
      if a.last == town.name
        final_routes.delete(node)
        branches = a * town.routes.count
        branches.each do |branch|
          n = town.routes.collect { |i| i.end_point }
          l = branch + n.pop
          final_routes << l
        end
      end
    end
    final_routes
  end

  def self.shortest_route(starting_town, ending_town)
    distance = 0
    starting_town = Town.find(starting_town)
    ending_town = Town.find(ending_town)
    current_town = nil
    current_town, distance_traveled = starting_town.shortest_route
    distance += distance_traveled
    while current_town != ending_town
      current_town, distance_traveled = current_town.shortest_route
      distance += distance_traveled
    end
    distance
  end
end