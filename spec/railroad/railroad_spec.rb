require './spec/spec_helper'

describe Railroad do

  let(:railroad) do
    Railroad.new('AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7')
  end

  describe ".distance" do

    context "given a route exists" do

      it "calculates the distance for the first test route" do
        distance = railroad.distance('A', 'B', 'C')
        expect(distance).to eq 9
      end

      it "calculates the distance for the second test route" do
        distance = railroad.distance('A', 'D')
        expect(distance).to eq 5
      end

      it "calculates the distance for the third test route" do
        distance = railroad.distance('A', 'D', 'C')
        expect(distance).to eq 13
      end

      it "calculates the distance for the fourth test route" do
        distance = railroad.distance('A', 'E', 'B', 'C', 'D')
        expect(distance).to eq 22
      end
    end

    context "given a route does not exist" do

      it "declares that the specified route does not exist" do
      end
    end
  end

  describe '#routes_between' do
  end

  describe ".routes_by_stops" do

    context "given a maximum number of stops" do

      it "calculates the number of routes between two towns- first test" do
        i = railroad.routes_by_stops('C', 'C', 3, 'maximum')
        expect(i).to eq 2
      end
    end

    context "given an exact number of stops" do

      it "calculates the number of routes between two towns- second test" do
        i = railroad.routes_by_stops('A', 'C', 4, 'exact')
        expect(i).to eq 3
      end
    end
  end

  describe ".shortest_route" do

    it "calculates the shortest route between two towns for the eighth test" do
      shortest = railroad.shortest_route('A', 'C')
      expect(shortest).to eq 9
    end

    it "calculates the shortest route between two towns for the ninth test" do
      pending
      shortest = railroad.shortest_route('B', 'B')
      expect(shortest).to eq 9
    end
  end

  describe ".routes_by_distance" do

    context "given a maximum distance" do

      it "calculates the number of routes between two towns" do
        number_routes = railroad.routes_by_distance('C', 'C', 30)
        expect(number_routes).to eq 7
      end
    end
  end
end
