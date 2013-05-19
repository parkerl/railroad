class Railroad

  def self.map(*routes)
    @map ||= RouteMap.build_map(routes)
  end

  def self.distance(*towns)
    distance = 0

    stops = towns.flatten.collect { |t| find_town(t) }

    stops.each_with_index do |current_town, index|
      break if index == stops.length - 1
      next_town = stops[index + 1]
      distance += current_town.distance_to(next_town)
    end
    distance
  end

  def self.routes_by_distance(starting_town, ending_town, max)
    routes = routes_between(starting_town, ending_town)
    routes.select { |i| distance(i.split("")) < max }.count
  end

  def self.routes_by_stops(starting_town, ending_town, max)
    available_routes = routes_between(starting_town, ending_town)
    available_routes.select { |i| stops(i) < max }.count
  end

  def self.routes_between(starting_town, ending_town)


    starting_town = find_town(starting_town) 
    paths, nodes = routes_from(starting_town), neighbors_to(starting_town)

    loop do 
      paths = nodes.collect { |town| expand_branch(town, paths) }.flatten!
      nodes = traverse(nodes).flatten!
      nodes = nodes.select { |node| node.name != ending_town }

      break if nodes == []

      nodes = nodes.select { |node| node.name != ending_town  }
    end
    final(paths, ending_town)
  end

  def self.final(paths, town_name)
    paths.each do |p|
      a = p.split("")
      if a.last != town_name
        i = p + town_name
        paths << i
        paths.delete(p)
      end
    end
    paths.uniq
  end

  def self.shortest_route(starting_town, ending_town)

    shortest = nil
    available_routes = routes_between(starting_town, ending_town)
    available_routes.each do |r|
      route_distance = distance(r.split(""))
      if (shortest == nil) || ( route_distance < shortest )
        shortest = route_distance
      end
    end
    shortest
  end

  private 

  def self.stops(route)
    route.length - 1
  end

  def self.en_route(nodes, ending_town)
    nodes.select { |node| node.name != ending_town }
  end

  def self.arrived?(current_town, destination)
    current_town == destination
  end

  def self.routes_from(town)
    town.routes.collect { |r| "#{town.name}#{r.end_point}" }
  end

  def self.expand(town, branch)
    town.routes.collect { |r| "#{branch}#{r.end_point}" }
  end

  def self.neighbors_to(town)
    town.routes.collect { |r| find_town(r.end_point) } 
  end

  def self.traverse(nodes)
    nodes.collect { |t| neighbors_to(t)}
  end

  def self.find_town(town)
    Town.find(town)
  end

  def self.expand_branch(town, paths)
    towns_branches = []
    paths.each do |n|
      route = n.split("")
      if route.last == town.name
        towns_branches << expand(town, n)
        paths.delete(n)
      end
    end
    paths + towns_branches.flatten!
  end
end

