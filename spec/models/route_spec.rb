require 'spec_helper'

describe Route do
  it { should have_db_column(:start) }
  it { should have_db_column(:end) }
  it { should have_db_column(:current) }
  it { should have_db_column(:start_address) }
  it { should have_db_column(:end_address) }
  it { should have_and_belong_to_many(:users) }
  it { should have_many(:current_users) }
  it { should have_many(:route_points) }
end