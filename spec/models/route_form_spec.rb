require 'spec_helper'

describe RouteForm do
  let :user do
    FactoryGirl.create(:user)
  end

  let :route_form do
    rf = RouteForm.new(:user_id => user.id,
      :start_latitude => 34.0128358,
      :start_longitude => -118.495338,
      :end_address => "1520 2nd Street, Santa Monica, CA 90401")
    rf.save
    rf
  end

  let :route do
    route_form.route
  end

  let :nearby_routes do
    route_form.nearby_routes
  end

  let :geocode_results do
    double(Object).tap do |gcr|
      gcr.stub(:coordinates) { [ 34.0128358, -118.495338 ]}
    end
  end

  let :double_routes do
    [double(Route), double(Route) ]
  end

  let :route_proximity_query do
    double(RouteProximityQuery).tap do |rpq|
      rpq.stub(:routes) { double_routes }
    end
  end

  before do
    Geocoder.should_receive(:search).at_least(1).times.with("1520 2nd Street, Santa Monica, CA 90401").and_return([geocode_results])
  end

  describe "route" do
    it "should save an object with correct parameters" do
      expect(route.start_point).to be_within_geographic(1).of(34.0128358, -118.495338)
      expect(route.end_point).to be_within_geographic(1).of(34.0128358, -118.495338)
      expect(route.users).to include(user)
      expect(route.current_users).to include(user)
    end
  end

  describe "user" do
    before do
      route
    end

    it "should update the user's properties" do
      expect(user.reload.current_route).to eq(route)
      expect(user.routes).to include(route)
    end
  end

  describe "nearby_routes" do
    before do
      RouteProximityQuery.should_receive(:new).and_return(route_proximity_query)
    end

    it "should return nearby routes" do
      expect(nearby_routes).to eq(double_routes)
    end
  end

end
