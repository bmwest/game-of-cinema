require 'rails_helper'

# [] Visiting the `/theaters` path should contain a list of theaters.

feature "visitor sees information for a specific theater" do
  scenario "sees theater information and link to edit and destroy" do
    user = FactoryGirl.create(:user, role: 'member')
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177', user: user)

    visit theater_path(amc)

    expect(page).to have_content amc.name
    expect(page).to have_content amc.address
    expect(page).to have_content amc.city
    expect(page).to have_content amc.state
    expect(page).to have_content amc.zip

    expect(page).to have_link "Delete Theater"
    expect(page).to have_link "Edit"
  end

  scenario "authenticated user clicks link and is taken to edit" do
    user = FactoryGirl.create(:user, role: 'member')
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177', user: user)

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
    user = FactoryGirl.create(:user, role: 'member')
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177', user: user)

    visit theater_path(amc)
    click_link "Delete Theater"

    expect(page).to_not have_content "AMC"
  end

  scenario "unauthenticated user clicks link and is taken to edit" do
    user = FactoryGirl.create(:user, role: 'member')

    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177', user: user)

    visit root_path

    visit theater_path(amc)
    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Theater")
  end
end
