require 'rails_helper'

feature "Authenticated user deletes restaurant" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant) }
  let!(:restaurant2) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to delete a restaurant
  # Because I refuse to dine there anymore

  # ACCEPTANCE CRITERIA
  # [ ] I can click a delete button on the restaraunt show page
  # [ ] The restaurant is removed from the restaurants index
  # [ ] I am taken back to the restaurants index

  scenario "restaraunt is removed" do
    login_as_user(user1)
    click_on restaurant1.name
    click_on "Delete"

    expect(page).to_not have_content(restaurant1.name)
    expect(page).to have_content(restaurant2.name)
    expect(page).to have_content("Restaurant Destroyed")
  end
end
