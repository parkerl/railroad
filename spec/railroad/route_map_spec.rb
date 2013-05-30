require './spec/spec_helper'

describe RouteMap do
  describe '.build_map' do
    it 'should create a new RouteMap with towns for each route description passed in' do
      route_description = 'AB1'
      RouteMap.build_map([ route_description ]).towns.map(&:name).should == ['A', 'B']
    end

    it 'should setup the route between towns correctly' do
      route_description = 'AB1'
      town = RouteMap.build_map([ route_description ]).towns.first
      town.routes.count.should == 1
      route = town.routes.first
      route.distance.should == 1
      route.destination.name.should == 'B'
    end

    it 'should not create a town twice' do
      route_descriptions = ['AB1', 'BC2', 'CB3']
      RouteMap.build_map( route_descriptions ).towns.map(&:name).should == ['A', 'B', 'C']
    end
  end

  describe '#find_or_create_town' do
    it 'should add a new town to the map' do
      map = RouteMap.new
      map.find_or_create_town('Some Town')
      map.towns.map(&:name).should == ['Some Town']
    end

    it 'should return an existing town' do
      map = RouteMap.new
      town = map.find_or_create_town('Some Town')
      existing_town = map.find_or_create_town('Some Town')
      town.should == existing_town
    end
  end

  describe '#find_town' do
    it 'should return the town with the specified name' do
      map = RouteMap.new
      town = map.find_or_create_town('Test')
      map.find_town('Test').should == town
    end
  end
end

