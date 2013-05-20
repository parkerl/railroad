require './spec/spec_helper'

describe Route do 

  describe ".new" do 

    it "has a destination" do 
      destination = Town.new('A')
      distance_to_destination = 5
      route = Route.new(destination, distance_to_destination)
      expect(route.destination).to eq destination
    end

    it "has a distance" do
      destination = Town.new('A')
      route = Route.new(destination, 5)
      expect(route.distance).to eq 5
    end
  end
end
