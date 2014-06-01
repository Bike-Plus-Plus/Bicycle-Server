require 'spec_helper'

describe RoutesController do
  describe 'POST create' do
    describe 'logged out' do
      it "should not be authorized" do
        post :create
        response.status.should == 401
      end
    end

    describe 'logged in' do
      let :user do
        FactoryGirl.build_stubbed(:user)
      end

      let :route do
        FactoryGirl.build_stubbed(:route)
      end

      before do
        controller.stub(:current_user) { user }
      end

      let :route_params do
        {
          :start_address => "1520 2nd Street, Santa Monica, CA 90401",
          :end_address => "123 Fake St, Downtown, LA 12345"
        }
      end

      describe "on successful save" do

        let :route_form do
          mock(RouteForm).tap do |rf|
            rf.stub(:save) { true }
            rf.stub(:route) { route }
            rf.stub(:user=) { }
          end
        end

        before do
          RouteForm.should_receive(:new).and_return(route_form)
          post :create, route: route_params
        end

        it "should return created status" do
          response.status.should == 201
        end

        it "should wrap around route" do
          JSON.parse(response.body).should include('route')
        end
      end

      describe "on failed save" do
        let :route_form do
          mock(RouteForm).tap do |rf|
            rf.stub(:save) { false }
            rf.stub(:errors) { { :email => "Can't be blank" }}
            rf.stub(:user=) { }
          end
        end

        before do
          RouteForm.should_receive(:new).and_return(route_form)
          post :create, route: route_params
        end

        it "should return unprocessable entity" do
          response.status.should == 422
        end

        it "should return errors" do
          JSON.parse(response.body).should include('email')
        end
      end
    end
  end

  describe 'GET show' do
    let :route do
      FactoryGirl.create(:route)
    end

    describe 'logged out' do
      it "should not be authorized" do
        get :show, id: route.id
        response.status.should == 401
      end
    end

    describe 'logged in' do
      let :user do
        FactoryGirl.build_stubbed(:user)
      end

      before do
        controller.stub(:current_user) { user }
        get :show, id: route.id
      end

      it "should succeed" do
        response.should be_success
      end

      it "should wrap around route" do
        JSON.parse(response.body).should include('route')
      end
    end
  end
end
