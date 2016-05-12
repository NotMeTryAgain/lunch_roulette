require 'rails_helper'

feature "User plays Lunch Roulette", js: true do
  # let!(:user1) { FactoryGirl.create(:user) }
  # let!(:restaurant1) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to visit Lunch Roulette
  # So I can play

  # ACCEPTANCE CRITERIA
  # [ ] I see a map with my location
  # [ ] If there are no restaurants in my immediate vicinity I am notified
  # [ ] There is a 'Play!' button
  # [ ] When I click 'Play!' I am presented with a random restaurant within my vicinity

  scenario "clicks Play!" do
    visit root_path
    click_on "Play!"

    expect(page).to have_css('div#map')
    expect(page.current_path).to eq root_path
  end
end
