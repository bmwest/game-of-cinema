require 'rails_helper'

# [] Visiting the `/theaters` path should contain a list of theaters.

feature "visitor sees a list of theaters" do
  scenario "sees a list of theaters and link for new theater" do
    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177')
    regal = Theater.create(name: "Regal Cinemas", address: "Beach streer", city: "Phildelphia", state: "PA", zip: "19701")

    visit theaters_path

    expect(page).to have_content "AMC"
    expect(page).to have_link "Regal Cinemas"

    click_link "Add New Theater"

    expect(page).to have_content "New Theater Form"
  end
end
