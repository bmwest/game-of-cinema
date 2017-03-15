require 'rails_helper'

feature "user visits the homepage" do
  let!(:user1) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater1) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater2) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater3) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater4) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater5) { FactoryGirl.create(:theater, user: user1) }
  let!(:theater6) { FactoryGirl.create(:theater, user: user1) }
  let!(:review1) { Review.create(rating: 3, theater: theater1, user: user1) }
  let!(:review2) { Review.create(rating: 3, theater: theater2, user: user1) }
  let!(:review3) { Review.create(rating: 3, theater: theater4, user: user1) }
  let!(:review4) { Review.create(rating: 3, theater: theater5, user: user1) }
  let!(:review5) { Review.create(rating: 3, theater: theater6, user: user1) }

  scenario "user sees theaters with the most reviews" do
    visit root_path

    expect(page).to have_content("Most Reviewed Theaters")
    expect(page).to have_content(theater1.name)
    expect(page).to have_content(theater2.name)
    expect(page).to have_content(theater4.name)
    expect(page).to have_content(theater5.name)
    expect(page).to have_content(theater6.name)
    expect(page).to_not have_content(theater3.name)
  end
end
