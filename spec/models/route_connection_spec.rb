require 'spec_helper'

describe RouteConnection do

  describe 'create_between' do
    let :route1 do
      FactoryGirl.create(:route)
    end

    let :route2 do
      FactoryGirl.create(:route)
    end

    before do
      RouteConnection.create_between(route1,
        route2,
        4.0,
        5.0,
        6.0)
      @rc1 = RouteConnection.first
      @rc2 = RouteConnection.last
    end

    it "should setup relationships" do
      route1.reload.nearby_routes.should include(route2)
      route2.reload.nearby_routes.should include(route1)
    end

    it "should set values for route connections" do
      expect(@rc1.start_range).to eq(4.0)
      expect(@rc1.end_range).to eq(5.0)
      expect(@rc1.angle_diff).to eq(6.0)
      expect(@rc2.start_range).to eq(4.0)
      expect(@rc2.end_range).to eq(5.0)
      expect(@rc2.angle_diff).to eq(6.0)
    end

  end
end
