class Railroad

  def self.map(*routes)
    @map ||= RouteMap.build_map(routes)
  end

  def self.distance(*towns)
    distance = 0
    towns_in_route = towns.collect { |town| Town.find_by_name(town) }
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

  def self.shortest_route(starting_town, ending_town)
    find_route(starting_town, ending_town)
  end

  def self.find_route(starting_town, ending_town)
    distance = 0
    starting_town = Town.find_by_name(starting_town)
    current_town = nil
    ending_town = Town.find_by_name(ending_town)
    current_town, distance_traveled = travel_from(starting_town)
    distance += distance_traveled
    while current_town != ending_town
      current_town, distance_traveled = travel_from(current_town)
      distance += distance_traveled
    end
    distance
  end

  def self.travel_from(town)
    route = town.shortest_route
    #from the town
    #return the town's shortest route
    #return an array that is the next town, and the distance from the route
  end
end