require 'spec_helper'

describe User do
  it { should have_db_column(:first_name) }
  it { should have_db_column(:last_name) }
  it { should have_db_column(:email) }
  it { should have_db_column(:password_digest) }
  it { should belong_to(:current_route) }
  it { should have_and_belong_to_many(:routes) }
end