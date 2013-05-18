class Railroad

  def self.map(*routes)
    @map ||= RouteMap.build_map(routes)
  end

  def self.distance(*towns)
    distance = 0

    towns_in_route = towns.flatten.collect { |t| Town.find(t) }
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

  def self.max_by_miles(starting_town, ending_town, max_distance)
    available_routes = all_routes(starting_town, ending_town)
    available_routes.select { |i| distance(i.split("")) < max_distance }.count
  end

  def self.max_by_stops(starting_town, ending_town, max_stops)
    available_routes = all_routes(starting_town, ending_town)
    available_routes.select { |i| stops(i) < max_stops }.count
  end

  def self.stops(route)
    route.length - 1
  end

  def self.all_routes(starting_town, ending_town)

    starting_town = Town.find(starting_town)
    paths, nodes = add_paths(starting_town)

    while !( nodes.all? { |node| node.name == ending_town })
      paths = nodes.collect { |town| expand_branch(town, paths.flatten) }.flatten
      nodes = traverse(nodes)
      nodes = nodes.select { |node| node.name != ending_town }
    end
    paths.uniq
  end

  def self.add_paths(town, paths = [], nodes = [])
    town.routes.each do |route|
      paths << "#{town.name}#{route.end_point}"   
      nodes << Town.find(route.end_point)
    end
    [paths, nodes]
  end

  def self.traverse(nodes)
    end_routes = nodes.collect { |node| node.routes }
    new_nodes = end_routes.flatten.collect { |route| route.end_point }
    nodes.clear
    nodes = new_nodes.collect { |node| Town.find(node) }
  end

  def self.expand_branch(town, paths)
    final_routes = paths
    paths.each do |node|
      a = node.split("")
      if a.last == town.name
        n = town.routes.collect { |i| i.end_point }
        1.upto(town.routes.count) do |i|
          l = node + n.pop
          final_routes << l
        end
        final_routes.delete(node)
      end
    end
    final_routes.flatten
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