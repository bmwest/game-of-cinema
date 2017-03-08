require 'rails_helper'

feature "visitor sees a list of theaters" do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater1) { FactoryGirl.create(:theater, user: user) }
  let!(:theater2) { FactoryGirl.create(:theater, user: user) }

  scenario "sees a list of theaters and link for new theater" do
    visit root_path
    expect(page).to have_content theater1.name
    expect(page).to have_link theater2.name
  end

  scenario "clicks link and is taken to show page for given theater" do
    visit theaters_path

    click_link theater1.name

    expect(page).to have_content theater1.name
    expect(page).to have_content theater1.address
    expect(page).to have_content theater1.city
    expect(page).to have_content theater1.state
    expect(page).to have_content theater1.zip
  end

end
