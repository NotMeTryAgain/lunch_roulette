require 'rails_helper'

feature "Authenticated user deletes restaurant" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant) }
  let!(:restaurant2) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to delete a restaurant
  # Because I refuse to dine there anymore

  # ACCEPTANCE CRITERIA
  # [x] I can click a delete button on the restaraunt show page
  # [x] The restaurant is removed from the restaurants index
  # [x] I am taken back to the restaurants index

  scenario "restaraunt is removed" do
    login_as_user(user1)
    click_on "Favorites"
    click_on "Add Eatery"
    fill_in "Name", with: "Pizza Hut"
    click_on "Submit"

    expect(page).to have_content("Pizza Hut")

    click_on "Pizza Hut"
    click_on "Delete"

    expect(page).to_not have_content("Pizza Hut")
    expect(page).to have_content("Restaurant Destroyed")
    expect(page.current_path).to eq restaurants_path
  end
end
