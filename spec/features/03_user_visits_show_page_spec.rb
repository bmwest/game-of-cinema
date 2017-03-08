require 'rails_helper'

feature "visitor sees information for a specific theater" do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user) }

  scenario "sees theater information and link to edit and destroy" do
    sign_in(user)
    visit theater_path(theater)

    expect(page).to have_content theater.name
    expect(page).to have_content theater.address
    expect(page).to have_content theater.city
    expect(page).to have_content theater.state
    expect(page).to have_content theater.zip

    expect(page).to have_link "Delete Theater"
    expect(page).to have_link "Edit"
  end

  scenario "authenticated user clicks link and is taken to edit" do
    sign_in(user)
    visit theater_path(theater)
    click_link "Edit"
    expect(page).to have_content "Editing #{theater.name}"

    fill_in 'State', with: "New Jersey"
    fill_in 'City', with: "Freehold"
    click_button "Add Theater"

    expect(page).to have_content "New Jersey"
    expect(page).to_not have_content theater.state

    expect(page).to have_content "Freehold"
    expect(page).to_not have_content theater.city
  end

  scenario "clicks delete link and record is removed" do
    sign_in(user)
    visit theater_path(theater)
    click_link "Delete Theater"

    expect(page).to_not have_content theater.name
  end

  scenario "unauthenticated user clicks link and is taken to edit" do
    visit root_path
    click_link(theater.name)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Theater")
  end
end
