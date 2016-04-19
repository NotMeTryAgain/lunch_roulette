require 'rails_helper'

feature "Authenticated user edits restaurant details" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:restaurant1) { FactoryGirl.create(:restaurant) }
  let!(:restaurant2) { FactoryGirl.create(:restaurant) }

  # As an authenticated user
  # I want to edit restaurant details
  # To update the address or category

  # ACCEPTANCE CRITERIA
  # [x] I can update any field of the restaurant details
  # [x] I view the updated details upon submitting my edits

  scenario "successfully edits details" do
    login_as_user(user1)
    click_on restaurant1.name
    click_on "Edit"
    fill_in "Name", with: "Baboo"
    fill_in "Category", with: "Pasta"
    fill_in "Address", with: "14 Pleasant St."
    fill_in "City", with: "Portland"
    fill_in "State", with: "ME"
    fill_in "Zip", with: 01235
    click_on "Submit"


    expect(page).to have_content("Baboo")
    expect(page).to have_content("Pasta")
    expect(page).to have_content("14 Pleasant St.")
    expect(page).to have_content("Portland")
    expect(page).to have_content("ME")
    expect(page).to_not have_content(restaurant1.name)
  end

  scenario "somehow botches the detail edit" do
    login_as_user(user1)
    click_on restaurant1.name
    click_on "Edit"
    fill_in "Name", with: ""
    fill_in "Category", with: "PPPPPPPPPPPPPPPPPPpPPPPPPPPPPPPPPPPPPPPPPPPPPPPP,
      PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
    fill_in "Address", with: "14 Pleasant Stttttttttttttttttttttttttttttttttttt,
    sssssssssshshshshshshshshshshshshshshshshshshshshshshshshshshshshshshshshsh"
    fill_in "City", with: "Portlandliuahsdliuhwfliduhalsiduhalisudlaiusdhliuags"
    fill_in "State", with: "MEP"
    fill_in "Zip", with: "aaaaaa"
    click_on "Submit"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Category is too long")
    expect(page).to have_content("Address is too long")
    expect(page).to have_content("City is too long")
    expect(page).to have_content("State is too long")
    expect(page).to have_content("Zip is too long")
  end

  scenario "decides against editing, navigates back to restaurant show page" do
    login_as_user(user1)
    click_on restaurant1.name
    click_on "Edit"
    click_on "Back to #{restaurant1.name}"
  end
end
