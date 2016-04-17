require 'rails_helper'

feature 'user signs up' do
  # As an unauthenticated user
  # I want to sign up
  # So that I can add restaurant to my favorites list

  # ACCEPTANCE CRITERIA
  # [ ] I must specify a valid username
  # [ ] I must specify a valid email address
  # [ ] I must specify a valid password and confirm that password
  # [ ] If I do not perform the above I get an error message
  # [ ] If I specify valid information, I am registered and authenticated

  scenario "specifying valid and required information" do
    visit root_path
    click_link "Sign Up"
    fill_in "Username", with: "honeyBear"
    fill_in "Email", with: "honeyBear@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"

    expect(page).to have_content("Welcome to Lunch Roulette!")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not supplied" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmtion does not match confirmation" do
    visit root_path
    click_link "Sign Up"
    fill_in "Username", with: "honeyBear"
    fill_in "Email", with: "honeyBear@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "wrongpassword"
    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
