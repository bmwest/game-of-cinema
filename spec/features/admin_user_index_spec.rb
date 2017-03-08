require 'rails_helper'

feature 'admin sees all users' do
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

  scenario "admin visits user index page through link" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign In"

    expect(page).to have_link("All Users")

    click_link "All Users"

    expect(page).to have_content user.first_name
  end

  scenario "admin visits the users index page directly" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign In"

    visit admin_users_path

    expect(page).to have_content user.first_name
  end

  scenario "users cannot visit users index page" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to_not have_link("All Users")

    visit admin_users_path

    expect(page).to_not have_content user.first_name
  end
end
