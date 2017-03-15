require "rails_helper"

feature 'sign_up' do
  scenario 'specify valid and required information' do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "email@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button 'Sign Up'
    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not supplied" do
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match" do
    visit root_path
    click_link "Sign Up"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "incorrectpassword"

    click_button "Sign Up"
    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
