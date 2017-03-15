require "rails_helper"

feature 'user signs out' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }

  scenario "user signs out" do
    sign_in(user)
    click_link "Sign Out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Sign In")
    expect(page).to_not have_content("Sign Out")
  end
end
