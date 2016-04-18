FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "honeybear#{n}"}
    sequence(:email) {|n| "honeybear#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
  end

  factory :restaurant do
    sequence(:name) {|n| "Zanzibar#{n}"}
    sequence(:category) {|n| "Pizza#{n}"}
    sequence(:address) {|n| "6#{n} Murdock St."}
    city 'Boston'
    state 'MA'
  end
end
