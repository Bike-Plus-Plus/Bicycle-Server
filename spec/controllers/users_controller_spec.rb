require 'spec_helper'

describe UsersController do

  describe 'GET show' do
    describe "logged out" do
      it "should be unauthorized" do
        get :show
        response.status.should == 401
      end
    end

    describe "logged_in" do
      let :user do
        FactoryGirl.build_stubbed(:user)
      end

      before do
        controller.stub(:current_user) { user }
        get :show
      end

      it "should succeed" do
        response.should be_success
      end

      it "should wrap around users" do
        JSON.parse(response.body).should include('user')
      end
    end
  end

  describe "POST create" do
    describe "successful create" do
      let :user_params do
        {
          first_name: "Bob",
          last_name: "Benson",
          email: "bob@bob.com",
          password: "apples",
          password_confirmation: "apples"
        }
      end

      it "should create a user" do
        expect do
          post :create, :user => user_params
        end.to change(User, :count).by(1)
      end

      it "should respond with created code" do
        post :create, :user => user_params
        response.status.should == 201
      end

      it "should wrap around user" do
        post :create, :user => user_params
        JSON.parse(response.body).should include('user')
      end
    end

    describe "with bad parameters" do
      let :user_params do
        {
          first_name: "Bob",
          last_name: "Benson",
          email: "bob.com",
          password: "apples",
          password_confirmation: "apples"
        }
      end

      it "should not create a user" do
        expect do
          post :create, :user => user_params
        end.to_not change(User, :count).by(1)
      end

      it "should respond with unprocessable entity" do
        post :create, :user => user_params
        response.status.should == 422
      end

      it "should wrap around the attribute with an error" do
        post :create, :user => user_params
        JSON.parse(response.body).should include('email')
      end
    end
  end

  describe "PUT update" do

    describe "logged out" do
      it "should be unauthorized" do
        put :update
        response.status.should == 401
      end
    end


    describe "logged in" do
      let! :user do
        FactoryGirl.create(:user)
      end

      before do
        controller.stub(:current_user) { user }
      end

      describe "successful update" do
        let :user_params do
          {
            first_name: "Bob",
            last_name: "Benson",
            email: "bob@bob.com",
            password: "apples",
            password_confirmation: "apples"
          }
        end

        it "should respond with created code" do
          put :update, :user => user_params
          response.status.should == 204
        end

        it "should update the user" do
          put :update, :user => user_params
          user.reload.email.should == "bob@bob.com"
        end
      end

      describe "with bad parameters" do
        let :user_params do
          {
            first_name: "Bob",
            last_name: "Benson",
            email: "bob.com",
            password: "apples",
            password_confirmation: "apples"
          }
        end

        it "should respond with unprocessable entity" do
          put :update, :user => user_params
          response.status.should == 422
        end

        it "should wrap around the attribute with an error" do
          put :update, :user => user_params
          JSON.parse(response.body).should include('email')
        end
      end
    end
  end

  describe "DELETE destroy" do

    describe "logged out" do
      it "should be unauthorized" do
        delete :destroy
        response.status.should == 401
      end
    end


    describe "logged in" do
      let :user do
        FactoryGirl.create(:user)
      end

      before do
        controller.stub(:current_user) { user }
      end

      it "should respond with created code" do
        delete :destroy
        response.status.should == 200
      end

      it "should delete the user" do
        delete :destroy
        expect(User.count).to be(0)
      end

    end
  end
end
