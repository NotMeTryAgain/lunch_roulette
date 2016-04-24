require "rails_helper"
feature "user sessions in unique" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  # As a logged in user
  # I only want to see my restaurants listed
  # Because this app is all about my tastes

  # ACCEPTANCE CRITERIA
  # [ ] I must only see restaurants I have posted
  # [ ] Other users restaurants are not visible to me

  scenario "session is unique" do
    login_as_user(user1)
    click_on "Favorites"
    click_on "Add Eatery"
    fill_in "Name", with: "Zambino's"
    click_on "Submit"
    click_on "Sign Out"
    login_as_user(user2)
    click_on "Favorites"
    click_on "Add Eatery"
    fill_in "Name", with: "TumYum"
    click_on "Submit"

    expect(page).to have_content "TumYum"
    expect(page).to_not have_content "Zambino's"
  end
end
