class Railroad
  attr_reader :map

  def initialize(*routes)
    @map = RouteMap.build_map(routes)
  end

  def distance(*towns)
  departure_town = map.find_town(towns.shift)

    routes_to_destination = towns.map do |town_name|
      next_town = map.find_town(town_name)

      route = departure_town.route_to(next_town)
      departure_town = route.destination
      route
    end

    routes_to_destination.map(&:distance).reduce(&:+)
  end

  def self.routes_by_distance(starting_town, ending_town, max)
    routes = routes_between(starting_town, ending_town)
    routes.select { |i| distance(i.split("")) <= max }.count
  end

  def self.routes_by_stops(starting_town, ending_town, max, type = 'maximum')
    available_routes = routes_between(starting_town, ending_town)
    final_routes = available_routes.select { |i| stops(i) == max }

    available_routes = available_routes.select { |i| stops(i) < max }

    # these loops with breaks are non-idiomatic ruby. It appears you are trying to use them to 
    # do a recursive process on the routes without actually using recursion.
    # This is definitly where you could impove things by applying 
    # some basic computer science.
    loop do

      available_routes.each do |r|
        last_town = r.split("").last
        next_routes = routes_between(last_town, ending_town)
        available_routes << next_routes.collect { |t| "#{r}#{t[1..-1]}" }.flatten
      end

      final_routes << available_routes.select { |i| stops(i) == max }.flatten!

      available_routes = available_routes.select { |i| stops(i) < max }.flatten!

      break if available_routes.empty? || (available_routes == nil)

    end

    final_routes
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
    #Single letter variable names are a code smell.
    paths.each do |p|
      a = p.split("")
      if a.last != town_name
        i = p + town_name
        #In general you should avoid modifying the collection
        #you are iterating over (paths).
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
    town.routes.collect { |r| "#{town.name}#{r.destination}" }
  end

  def self.expand(town, branch)
    town.routes.collect { |r| "#{branch}#{r.destination}" }
  end

  def self.neighbors_to(town)
    town.routes.collect { |r| find_town(r.destination) }
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

