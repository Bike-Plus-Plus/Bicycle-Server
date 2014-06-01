FactoryGirl.define do
  factory :user do
    first_name 'Bill'
    last_name 'Moyers'
    email 'test@test.com'
    password 'password'
    password_confirmation 'password'
  end
end
