require 'rails_helper'

feature 'admin deletes a theater' do
  let!(:user) do
    User.create(
      first_name: 'Elmo',
      last_name: 'World',
      email: 'sesamestreet@world.com',
      password: 'supersecret',
      password_confirmation: 'supersecret',
      role: 'member'
    )
  end

  let!(:admin) do
    User.create(
      first_name: 'Admin',
      last_name: 'World',
      email: 'whatatreet@world.com',
      password: 'supersecret',
      password_confirmation: 'supersecret',
      role: 'admin'
    )
  end

  scenario "admin deletes a theater" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign In"

    amc = Theater.create(name: 'AMC', address: '33 Harrison Ave', city: 'Phildelphia', state: 'PA', zip: '19177', user: user)

    visit theater_path(amc)

    expect(page).to have_content amc.name
    expect(page).to have_link "Remove #{amc.name}"

    click_link "Remove #{amc.name}"

    expect(page).to have_content("Theater was successfully destroyed.")
    expect(page).to_not have_content amc.name
  end
end
