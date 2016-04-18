require 'rails_helper'

feature "Authenticated user adds restaurants to list" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to add restaurants to my list
  # So that I can Roulette through the list

  # ACCEPTANCE CRITERIA
  # [x] I must specify a valid name for the restaurant
  # [x] I can optionally supply a category, address, city, and state
  # [x] If I fail to specify a name I am presented with an error
  # [x] If I provide valid information the restaurant is added to my list
  # [ ] The form is on the restaurants index page

  scenario "successfully adds restaurant" do
    login_as_user(user1)
    click_on "Add Eatery"
    fill_in "Name", with: restaurant1.name
    click_button "Add Restaurant"

    expect(page).to have_content(restaurant1.name)
  end

  scenario "restaurant is not saved" do
    login_as_user(user1)
    click_on "Add Eatery"
    click_button "Add Restaurant"
  
    expect(page).to have_content("can't be blank")
  end
end
