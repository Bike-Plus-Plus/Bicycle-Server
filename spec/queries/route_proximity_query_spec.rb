require 'spec_helper'

describe RouteProximityQuery, :type => :query do
  let! :my_route do
    Route.create(:start_address => "1520 2nd Street, Santa Monica, CA 90401", :end_address => "2190 W Washington Blvd, Los Angeles, CA 90018")
  end

  let! :on_route_not_dest do
    Route.create(:start_address => "1415 Third Street Promenade, Santa Monica, CA 90401", :end_address => "9409 Venice Blvd, Culver City, CA 90232")
  end

  let! :on_route_close_dest do
    Route.create(:start_address => "395 Santa Monica Place,
Santa Monica, CA 90401", :end_address => "2771 W Pico Blvd, Los Angeles, CA 90006")
  end

  let! :off_route_far_start_point do
    Route.create(:start_address => "9409 Venice Blvd, Culver City, CA 90232", :end_address => "2190 W Washington Blvd, Los Angeles, CA 90018")
  end

  let! :off_route_wrong_direction do
    Route.create(:start_address => "395 Santa Monica Place,
Santa Monica, CA 90401", :end_address => "15777 Bowdoin Street, Pacific Palisades, CA 90272")
  end

  let :routes do
    RouteProximityQuery.new(my_route).routes
  end

  describe "routes" do
    it "should include routes that are in the same location and direction" do
      routes.should include(on_route_not_dest)
      routes.should include(on_route_close_dest)
    end

    it "should not include routes that don't start in the same location" do
      routes.should_not include(off_route_far_start_point)
    end

    it "should not include routes that go in a different direction" do
      routes.should_not include(off_route_wrong_direction)
    end

    it "should order results by closeness of destinations" do
      routes.first.should == on_route_close_dest
    end
  end

end
