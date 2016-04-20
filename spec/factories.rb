FactoryGirl.define do
  factory :location do
    address "MyString"
    latitude 1.5
    longitude 1.5
  end
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
  
  end
end
