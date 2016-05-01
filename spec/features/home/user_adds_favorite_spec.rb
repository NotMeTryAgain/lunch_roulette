require 'rails_helper'

feature "User visits Lunch Roulette", js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to visst Lunch Roulette
  # So I can play

  # ACCEPTANCE CRITERIA
  # [ ] I see a map with my location
  # [ ] There is a 'Play!' button

  scenario "successfully adds restaurant" do
    login_as_user(user1)

    expect(page).to have_css('div#map')
  end
end
