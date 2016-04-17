FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "honeybear#{n}"}
    sequence(:email) {|n| "honeybear#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
  end
end
