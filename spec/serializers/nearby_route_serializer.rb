require 'spec_helper'

describe NearbyRouteSerializer do
  let :route do
    FactoryGirl.create(:route)
  end

  describe 'as_json' do
    subject :json do
      NearbyRouteSerializer.new(route).to_json
    end

    it { should be_present }
    it { should have_json_path('nearby_route/id') }
    it { should have_json_path('nearby_route/start_latitude') }
    it { should be_json_eql(%(#{route.start_point.y})).at_path('nearby_route/start_latitude')}
    it { should have_json_path('nearby_route/start_longitude') }
    it { should be_json_eql(%(#{route.start_point.x})).at_path('nearby_route/start_longitude')}
    it { should have_json_path('nearby_route/end_latitude') }
    it { should be_json_eql(%(#{route.end_point.y})).at_path('nearby_route/end_latitude')}
    it { should have_json_path('nearby_route/end_longitude') }
    it { should be_json_eql(%(#{route.end_point.x})).at_path('nearby_route/end_longitude')}
    it { should have_json_path('nearby_route/current_latitude') }
    it { should be_json_eql(%(#{route.current.y})).at_path('nearby_route/current_latitude')}
    it { should have_json_path('nearby_route/current_longitude') }
    it { should be_json_eql(%(#{route.current.x})).at_path('nearby_route/current_longitude')}

  end
end


