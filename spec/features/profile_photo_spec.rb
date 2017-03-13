require "rails_helper"

feature 'user adds an avatar to profile' do

  scenario 'user adds an avatar' do
    visit root_path
    click_link "Sign Up"

    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "email@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "password"
    attach_file :user_avatar, File.join(Rails.root, 'spec', 'support', 'images', 'photo.png')
    click_button 'Sign Up'
    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")

    click_link "User Profile"
    expect(page).to have_css("img[src*='photo.png']")
  end

  scenario 'user removes an avatar' do
    visit root_path
    click_link "Sign Up"

    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "email@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "password"
    attach_file :user_avatar, File.join(Rails.root, 'spec', 'support', 'images', 'photo.png')
    click_button 'Sign Up'
    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")

    click_link "User Profile"
    fill_in "Email", with: "email@example.com"
    fill_in "Current password", with: "password"
    expect(page).to have_css("img[src*='photo.png']")

    check "Remove avatar"
    click_button 'Update'

    expect(page).to have_content("Your account has been updated successfully.")
    click_link "User Profile"
    expect(page).to_not have_css("img[src*='photo.png']")
  end
end
