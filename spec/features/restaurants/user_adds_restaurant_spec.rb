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
  # [ ] I can navigate back ot the restaurants index

  scenario "successfully adds restaurant" do
    login_as_user(user1)
    click_on "Favorites"
    click_on "Add New Eatery!"
    fill_in "Name", with: "Sambo"
    click_button "Submit"

    expect(page).to have_content("Sambo")

  end

  scenario "restaurant is not saved" do
    login_as_user(user1)
    click_on "Favorites"
    click_on "Add New Eatery!"
    click_button "Submit"

    expect(page).to have_content("Name can't be blank")
  end

  scenario "navigates back to restaurants index without adding anything" do
    login_as_user(user1)
    click_on "Favorites"
    click_on "Add New Eatery!"
    click_on "Favorites"

    expect(page.current_path).to eq restaurants_path
  end
end
