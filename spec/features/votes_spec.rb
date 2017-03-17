require 'rails_helper'

feature 'user upvotes' do
  let!(:user) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user) }
  let!(:review) { Review.create(rating: 3, body:"hello", theater: theater, user: user) }

  context 'authenticated user' do
    before do
      sign_in(user)
    end

    scenario 'upvote', js: true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#upvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 1')
      expect(page).to have_content('Downvotes: 0')
    end

    scenario 'user undos upvote', js: true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#upvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 1')

      page.all('#upvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 0')
      expect(page).to_not have_content('Upvotes: 1')
    end

    scenario 'user undos down', js: true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#downvote')[0].trigger('click')

      expect(page).to have_content('Downvotes: 1')

      page.all('#downvote')[0].trigger('click')

      expect(page).to have_content('Downvotes: 0')
      expect(page).to_not have_content('Downvotes: 1')
    end

    scenario 'downvote', js: true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#downvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 0')
      expect(page).to have_content('Downvotes: 1')
    end

    scenario 'user switches votes', js: true do
      visit theater_path(theater)

      expect(page).to have_selector('#upvote')
      expect(page).to have_selector('#downvote')

      page.all('#downvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 0')
      expect(page).to have_content('Downvotes: 1')

      page.all('#upvote')[0].trigger('click')

      expect(page).to have_content('Upvotes: 1')
      expect(page).to have_content('Downvotes: 0')
    end
  end
end
