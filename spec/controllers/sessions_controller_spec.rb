require 'spec_helper'

describe SessionsController do
  describe 'POST create' do
    before do
      @user = User.create(:email => "test@test.com",
        :password => "awesomeness",
        :password_confirmation => "awesomeness")
    end

    describe "with valid email + password" do
      before do
        post :create, :email => "test@test.com", :password => "awesomeness"
      end

      subject { ActiveSupport::JSON.decode(response.body) }

      its(["access_token"]) { should_not be_nil }
      its(["token_type"]) { should == 'bearer'}

    end

    describe "with incorrect email + password" do
      before do
        post :create, :email => "test@test.com", :password => "not awesome"
      end

      it "should return unauthorized" do
        response.response_code.should == 401
      end

      describe "body" do
        subject { ActiveSupport::JSON.decode(response.body) }

        its(["error"]) { should == "Email or password is invalid"  }
      end

    end
  end
end
