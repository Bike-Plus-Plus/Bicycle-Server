require 'spec_helper'

describe PointsController do
  describe "POST create" do
    let :route do
      FactoryGirl.create(:route, :in_progress => true)
    end

    describe 'logged out' do
      it "should not be authorized" do
        post :create, route_id: route
        response.status.should == 401
      end
    end

    describe 'logged in' do
      let :user do
        FactoryGirl.build_stubbed(:user)
      end

      before do
        controller.stub(:current_user) { user }
      end

      describe "on successful save" do
        let :point_params do
          {
            :latitude => 34.0128358, :longitude => -125.495338
          }
        end

        it "should create a route point" do
          expect do
            post :create, route_id: route, :point => point_params
          end.to change(RoutePoint, :count).by(1)
        end

        it "should change the current value for route" do
          post :create, route_id: route, :point => point_params
          expect(route.reload.current).to be_within_geographic(1).of(34.0128358,-125.495338)
        end

        it "should return created status" do
          post :create, route_id: route, :point => point_params
          response.status.should == 201
        end

        it "should wrap around route" do
          post :create, route_id: route, :point => point_params
          JSON.parse(response.body).should include('point')
        end
      end

      describe "on failed save" do
        let :route do
          FactoryGirl.create(:route)
        end

        let :point_params do
          {
            :latitude => 34.0128358, :longitude => -125.495338
          }
        end

        it "should not create a route point" do
          expect do
            post :create, route_id: route, :point => point_params
          end.to_not change(RoutePoint, :count).by(1)
        end

        it "should not change the current value for route" do
          post :create, route_id: route, :point => point_params
          expect(route.reload.current).to be_within_geographic(1).of(34.0128358,-118.495338)
        end

        it "should return unprocessable entity" do
          post :create, route_id: route, :point => point_params
          response.status.should == 422
        end

        it "should wrap around route" do
          post :create, route_id: route, :point => point_params
          JSON.parse(response.body).should include('base')
        end
      end
    end
  end
end