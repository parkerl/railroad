class RouteMap

  def self.build_map(routes)
    routes.each { |route| draw(route) }
    Town.all
  end

  def self.draw(route) 
    starting_town, ending_town, distance = (route).split("")
    town = Town.find_or_create(starting_town)
    town.add_route(ending_town, distance)
    self.draw_map(Town.all)
  end

  def self.draw_map(towns)
    #for each town
    #town's routes
      #generate a hash where the key is the beginning and ending point, and the values are:
        #all routes { ABC => [ 5, 10] }

  end
end