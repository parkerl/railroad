require './spec/spec_helper'

describe Town do 

  before do 
    Town.clear if (Town.all != nil)
  end

  describe ".new" do 

    it "has a name" do 
      pending
      town = Town.new('A')
      expect(town.name).to eq 'A'
    end
  end

  describe "#add_route" do 

    let(:town) { Town.new('A') }

    context "given the route does not exist" do 

      it "creates a new route for that town" do 
        pending
        town.add_route('B', 5)
        expect(town.routes.count).to eq 1
      end
    end
  end

  describe ".find_by_name" do 

    it "finds the town by its name" do 
    end
  end

  describe ".find_or_create" do 

    context "given a town already exists" do 

      before do 
        Town.all << Town.new('A')
      end

      it "returns that town" do 
        pending
        expect(Town.find_or_create('A').name).to eq 'A'
      end

      it "does not create a duplicate town" do 
        pending
        expect(Town.all.count).to eq 1
      end
    end

    context "given a town has not been created" do 

      it "creates and returns the town" do
        pending 
        expect(Town.find_or_create('A').name).to eq 'A'
      end
    end
  end
end