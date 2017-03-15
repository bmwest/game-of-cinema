require 'rails_helper'

feature 'user upvotes' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user) }
  let!(:review) { Review.create(rating:3, body:"hello", theater: theater, user: user) }

  context 'authenticated user' do
    before do
      sign_in(user)
    end

    scenario 'upvote', js:true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#upvote')[0].click

      expect(page).to have_content('1')
    end
  end
end
