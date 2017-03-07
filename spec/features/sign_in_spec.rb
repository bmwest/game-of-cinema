require "rails_helper"

feature 'user signs in' do
  scenario "existing user specifies valid login information" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
  end

  scenario "nonexistant log in information supplied" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: "noncorrect@email.com"
    fill_in "Password", with: "notcorrectPassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "Existing user supplies wrong password" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "notcorrectPassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an already authenticated user cannot re-sign in" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
  end
end
