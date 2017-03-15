require "rails_helper"

feature "user can add theater" do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }

  scenario "authenitcated user adds new theater successfully" do
    sign_in(user)

    click_link "Add New Theater"

    fill_in 'Name', with: "Movieeees"
    fill_in 'Address', with: "105 Beach St"
    fill_in 'City', with: "Phildelphia"
    fill_in 'State', with: "Pennsylvania"
    fill_in 'Zip', with: "17254"

    click_button "+"

    expect(page).to have_content "Theater added successfully"
    expect(page).to have_content "Movieeees"
    expect(page).to have_content "105 Beach St"
    expect(page).to have_content "Phildelphia"
    expect(page).to have_content "Pennsylvania"
    expect(page).to have_content "17254"
  end

  scenario "authenticated visitor does not provide proper information for a theater" do
    user = FactoryGirl.create(:user, role: 'member')
    sign_in(user)

    visit new_theater_path

    click_button "+"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip can't be blank"
    expect(page).to have_content "Zip is the wrong length (should be 5 characters)"
    expect(page).to have_content "Zip is not a number"
  end
end
