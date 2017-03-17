require 'rails_helper'

feature "user visits the homepage" do
  scenario "user visits homepage" do
    visit root_path
    expect(page).to have_current_path("/")
  end
end
