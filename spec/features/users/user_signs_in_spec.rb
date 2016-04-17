require 'rails_helper'

feature 'user signs in' do
  let!(:user) { FactoryGirl.create(:user) }
  # As a user
  # I want to sign in
  # So that I can add restaurants to my favorites list

  # ACCEPTANCE CRITERIA
  # [ ] I must specify a valid, previously registered username and password
  # [ ] I am authenticated and granted access to the system
  # [ ] If I specify invalid credentials, I remain unauthenticated
  # [ ] If I am already signed in, I can't sign in again

  scenario "an existing user specifies a valid email and password" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content("Let's Roulette!")
    expect(page).to have_content("Sign Out")
  end

  scenario "a non-existent user attempts to sign-in and is denied access" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: 'holy@smokes.com'
    fill_in "Password", with: 'password'
    click_button "Log In"

    expect(page).to_not have_content("Let's Roulette!")
    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "an existing username with an invalid password is denied access" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: 'wrongpassword'
    click_button "Log In"

    expect(page).to_not have_content("Let's Roulette!")
    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "an authenticated user cannot re-sign in" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path

    expect(page).to have_content("You are already signed in!")
  end
end
