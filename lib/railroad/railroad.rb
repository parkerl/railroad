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
    puts " routes #{available_routes.inspect}"
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
    paths, nodes = add_branches(starting_town), add_nodes(starting_town)

    while !( nodes.all? { |node| arrived?(node.name, ending_town) })
      paths = nodes.collect { |town| expand_branch(town, paths) }.flatten!
      nodes = traverse(nodes).flatten
      nodes = not_arrived(nodes, ending_town)
    end
    paths
  end

  def self.not_arrived(nodes, ending_town)
    nodes.select { |node| node.name != ending_town }
  end

  def self.arrived?(current_town, destination)
    current_town == destination
  end

  def self.add_branches(town, branch = nil, paths = [])
    if branch
      town.routes.collect { |r| "#{branch}#{r.end_point}" }
    else
      town.routes.collect { |r| "#{town.name}#{r.end_point}" }
    end
  end

  def self.add_nodes(town)
    town.routes.collect { |r| Town.find(r.end_point) } 
  end

  def self.traverse(nodes)
    nodes.collect { |t| add_nodes(t)}
  end

  def self.expand_branch(town, paths)
    towns_branches = []
    paths.each do |n|
      a = n.split("")
      if continue_branch?(a.last, town.name)
        towns_branches << add_branches(town, n)
        paths.delete(n)
      end
    end
    paths + towns_branches.flatten!
  end

  def self.continue_branch?(path_end, node)
    path_end == node
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