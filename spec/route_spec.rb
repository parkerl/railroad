require './spec/spec_helper'

describe Route do 

  describe ".new" do 

    it "has an end point" do 
      route = Route.new('A', 5)
      expect(route.end_point).to eq 'A'
    end

    it "has a distance" do
      route = Route.new('A', 5)
      expect(route.distance).to eq 5
    end
  end
end