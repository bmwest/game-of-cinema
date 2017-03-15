require "rails_helper"

feature 'add a photo to a theater' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user) }

  scenario "user adds photo to their theater" do
    visit search_index_path
    sign_in(user)
    visit edit_theater_path(theater)

    attach_file :theater_image, File.join(Rails.root, 'spec', 'support', 'images', 'photo.png')
    click_button "+"

    expect(page).to have_css("img[src*='photo.png']")
  end

  scenario 'user removes a photo from their theater' do
    visit search_index_path
    sign_in(user)
    visit edit_theater_path(theater)

    attach_file :theater_image, File.join(Rails.root, 'spec', 'support', 'images', 'photo.png')
    click_button "+"

    visit edit_theater_path(theater)
    expect(page).to have_css("img[src*='photo.png']")

    check "theater_remove_image"
    click_button "+"

    expect(page).to_not have_css("img[src*='photo.png']")
  end
end
