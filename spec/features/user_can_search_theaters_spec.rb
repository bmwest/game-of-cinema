require 'rails_helper'

feature "user can search other users and theaters" do
  let!(:user1) { FactoryGirl.create(:user, role: 'member') }
  let!(:user2) { FactoryGirl.create(:user, role: 'member') }
  let!(:user3) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater1) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater2) { FactoryGirl.create(:theater, city: 'Burlington', state: 'Vermont', user: user2) }
  let!(:theater3) { FactoryGirl.create(:theater, state: 'Rhode Island', user: user3) }

  scenario "user searches theaters by name and sees all matches" do
    sign_in(user1)
    fill_in "Search", with: theater1.name
    click_button 'Search'

    expect(page).to have_content(theater1.name)
    expect(page).to_not have_content(theater2.name)
  end

  scenario "user searches theaters by state and sees all matches" do
    sign_in(user1)
    fill_in "Search", with: "Pennsylvania"
    click_button 'Search'

    expect(page).to have_content(theater1.name)
    expect(page).to_not have_content("There are currenty no listings matching 'Pennsylvania'")
  end

  scenario "user searches theaters by city and sees all matches" do
    sign_in(user1)
    fill_in "Search", with: "Burl"
    click_button 'Search'

    expect(page).to have_content(theater2.name)
    expect(page).to_not have_content("There are currenty no listings matching 'Burl'")
  end

  scenario "user sees an error message when no listings match their search" do
    sign_in(user1)
    fill_in "Search", with: 'New York'
    click_button 'Search'

    expect(page).to_not have_content(theater3.name)
    expect(page).to have_content("There are currenty no listings matching 'New York'")
  end

  scenario "user sees all theaters when no criteria is submitted" do
    sign_in(user1)
    fill_in "Search", with: ''
    click_button 'Search'

    expect(page).to have_content(theater1.name)
    expect(page).to have_content(theater2.name)
    expect(page).to have_content(theater3.name)
  end
end
