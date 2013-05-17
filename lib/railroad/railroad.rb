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
    #find the distance for all routes
    #return the routes that are under the given distance 
  end

  def self.all_routes(starting_town, ending_town)
    routes = []
    nodes = []
    starting_town.routes.each do |route|
      routes << [route.name]
      nodes << Town.find(route.end_point)
    end
    while !( nodes.all? { |node| node.end_point == ending_town.name })
      #
    end



    #find the route for the town
    #breadth first search
      #for the starting node
      #pick a node that hasn't been picked yet
      #keep going with this until all nodes have reached the final node
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