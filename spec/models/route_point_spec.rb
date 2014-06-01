require 'spec_helper'

describe RoutePoint do
  describe "convert_point" do
    it "should convert lat/lon to a point" do
      @rp = RoutePoint.create(:latitude => 34.0128358, :longitude => -118.495338)
      expect(@rp.point).to be_within_geographic(1).of(34.0128358, -118.495338)
    end
  end
end