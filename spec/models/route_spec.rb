require 'spec_helper'

describe Route do
  it { should have_db_column(:start_point) }
  it { should have_db_column(:end_point) }
  it { should have_db_column(:current) }
  it { should have_db_column(:start_address) }
  it { should have_db_column(:end_address) }
  it { should have_and_belong_to_many(:users) }
  it { should have_many(:current_users) }
  it { should have_many(:route_points) }
  it { should have_many(:route_connections) }
  it { should have_many(:nearby_routes).through(:route_connections) }

  describe "geocoding" do
    describe "start" do
      before do
        @route = Route.create(:start_address => "1520 2nd Street, Santa Monica, CA 90401")
      end

      it "should geocode start address correctly" do
        expect(@route.start_point).to be_within_geographic(200).of(34.0128358, -118.495338)
      end
    end


    describe "end" do
      before do
        @route = Route.create(:end_address => "1520 2nd Street, Santa Monica, CA 90401")
      end

      it "should geocode end address correctly" do
        expect(@route.end_point).to be_within_geographic(200).of(34.0128358, -118.495338)
      end
    end
  end

  describe "current" do
    before do
      @route = Route.create(:start_point => "POINT(-118.495338 34.0128358)")
    end

    it "should copy start to current on create" do
      expect(@route.current).to be_within_geographic(1).of(34.0128358, -118.495338)
    end
  end

end