require 'rails_helper'

# [] Visiting the `/theaters` path should contain a list of theaters.

feature "visitor sees information for a specific theater" do
  scenario "sees theater information and link to edit and destroy" do
    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177')

    visit theater_path(amc)

    expect(page).to have_content amc.name
    expect(page).to have_content amc.address
    expect(page).to have_content amc.city
    expect(page).to have_content amc.state
    expect(page).to have_content amc.zip

    expect(page).to have_link "Delete Theater"
    expect(page).to have_link "Edit"
  end

  scenario "clicks link and is taken to edit" do
    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177')

    visit theater_path(amc)
    click_link "Edit"
    expect(page).to have_content "Editing AMC"

    fill_in 'State', with: "New Jersey"
    fill_in 'City', with: "Freehold"
    click_button "Add Theater"

    expect(page).to have_content "New Jersey"
    expect(page).to_not have_content "PA"

    expect(page).to have_content "Freehold"
    expect(page).to_not have_content "Phildelphia"
  end

  scenario "clicks delete link and record is removed" do
    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177')

    visit theater_path(amc)
    click_link "Delete Theater"

    expect(page).to_not have_content "AMC"
  end
end
