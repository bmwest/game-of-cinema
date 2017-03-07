require "rails_helper"

# [] A restaurant must have a name, address, city, state, and zip code. It can optionally have a description.
# [] Visiting the `/restaurants/new` path should display a form for creating a new restaurant.
# [] When adding a new restaurant, if I fill out the form correctly, I should see the page for the newly created restaurant.
# [] When adding a new restaurant, if I fill out the form incorrectly and submit the form, I should see the form and be displayed the validation errors.


feature "user can add theater" do
  scenario "user adds new theater successfully" do

    visit new_theater_path
    expect(page).to have_content "New Theater Form"

    fill_in 'Name', with: "Movieeees"
    fill_in 'Address', with: "105 Beach St"
    fill_in 'City', with: "Phildelphia"
    fill_in 'State', with: "Pennsylvania"
    fill_in 'Zip', with: "17254"

    click_button "Add Theater"

    expect(page).to have_content "Theater added successfully"
    expect(page).to have_content "Movieeees"
    expect(page).to have_content "105 Beach St"
    expect(page).to have_content "Phildelphia"
    expect(page).to have_content "Pennsylvania"
    expect(page).to have_content "17254"
  end

  scenario "visitor does not provide proper information for a theater" do
    visit new_theater_path

    click_button "Add Theater"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip can't be blank"
    expect(page).to have_content "Zip is the wrong length (should be 5 characters)"
    expect(page).to have_content "Zip is not a number"
  end
end
