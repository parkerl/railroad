class RouteMap

  def self.build_map(routes)
    routes.each { |route| draw(route) }
    Town.all
  end

  def self.draw(route) 
    starting_town, ending_town, distance = (route).split("")
    town = Town.find_or_create(starting_town)
    town.add_route(ending_town, distance)
  end
end