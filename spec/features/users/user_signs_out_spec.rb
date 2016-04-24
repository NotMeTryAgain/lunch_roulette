require "rails_helper"
feature "user signs out" do
  let!(:user) { FactoryGirl.create(:user) }

  # As a logged in user
  # I want to sign out
  # 'Cause I am done with this roulette business

  # ACCEPTANCE CRITERIA
  # [x] I must click Sign Out
  # [x] If I click Sign Out, I am signed out..

  scenario "with success" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
    click_link "Sign Out"

    expect(page).to have_content "See you next time!"
  end
end
