require "rails_helper"

feature 'add a photo to a theater' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user) }

  scenario "user adds photo to their theater" do
    visit root_path
    sign_in(user)
    visit search_index_path
    visit theater_path(theater)
    visit edit_theater_path(theater)
    click_button "+"

    expect(page).to have_xpath("//img[contains(@src,'popcorn.jpg')]")
  end

  scenario 'user removes a photo from their theater' do
    visit root_path
    sign_in(user)
    visit search_index_path
    visit theater_path(theater)
    visit edit_theater_path(theater)

    expect(page).to have_xpath("//img[contains(@src,'popcorn.jpg')]")

    visit edit_theater_path(theater)

    check "theater_remove_image"
    click_button "+"

    expect(page).to_not have_xpath("//img[contains(@src,'popcorn.jpg')]")
  end
end
