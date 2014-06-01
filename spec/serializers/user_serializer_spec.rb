require "spec_helper"

describe UserSerializer do
  let :user do
    FactoryGirl.build_stubbed(:user)
  end

  describe 'as_json' do
    subject :json do
      UserSerializer.new(user).to_json
    end

    it { should be_present }
    it { should have_json_path('user/id') }
    it { should have_json_path('user/first_name') }
    it { should have_json_path('user/last_name') }
    it { should have_json_path('user/email') }
  end
end