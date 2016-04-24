require 'rails_helper'

feature "Authenticated user views restaurant details" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant, user_id: user1.id) }

  # As an authenticated user
  # I want to view restaurant details
  # To check the address or category/remind myself of why I added it in the first place

  # ACCEPTANCE CRITERIA
  # [x] I can click a restaurant name on the restaurant index and be taken to its show page
  # [x] I can view restaurant details
  # [x] I can navigate back to the restaurants index

  scenario "views details" do
    login_as_user(user1)
    click_on "Favorites"
    click_on restaurant1.name

    expect(page).to have_content(restaurant1.name)
    expect(page).to have_content(restaurant1.category)
    expect(page).to have_content(restaurant1.address)
    expect(page).to have_content(restaurant1.comments)
  end

  scenario "can navigate back to restaurants index" do
    login_as_user(user1)
    click_on "Favorites"
    click_on restaurant1.name
    click_link "Restaurants"

    expect(page).to have_content(restaurant1.name)
    expect(page.current_path).to eq restaurants_path
  end
end
