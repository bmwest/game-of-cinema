require "rails_helper"

feature 'user signs in' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }

  scenario "existing user specifies valid login information" do
    sign_in(user)

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
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "notcorrectPassword"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Welcome Back!")
  end

  scenario "an already authenticated user cannot re-sign in" do
    sign_in(user)
    visit new_user_session_path

    expect(page).to have_content("Sign Out")
    expect(page).to have_content("You are already signed in")
    expect(page).to_not have_content("Sign In")
  end
end
