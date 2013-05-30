class RouteMap

  def initialize
    @towns = {}
  end

  def self.build_map(routes)
    new_map = RouteMap.new

    routes.each do |route|
      starting_town_name, ending_town_name, distance = route.split("")

      starting_town = new_map.find_or_create_town(starting_town_name)
      ending_town = new_map.find_or_create_town(ending_town_name)

      starting_town.add_route(ending_town, distance.to_i)
    end
    new_map
  end

  def find_or_create_town(town_name)
    @towns[town_name] ||= Town.new(town_name)
  end

  def towns
    @towns.values
  end

  def find_town(town_name)
    @towns[town_name]
  end
end
