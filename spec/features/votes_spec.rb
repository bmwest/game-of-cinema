# require "rails_helper"
#
# feature "user votes on a review" do
#   let!(:user1) { FactoryGirl.create(:user, role: 'member') }
#   let!(:user2) { FactoryGirl.create(:user, role: 'member') }
#   let!(:theater) { FactoryGirl.create(:theater, user: user1) }
#   let!(:review) { Review.create(rating: 4, body: "this is a review", user: user1, theater: theater) }
#
#   scenario "authenitcated user can vote on a review" do
#     sign_in(user1)
#     visit theater_path(theater)
#
#     click_button "Upvote"
#
#     expect(page).to have_content("1 upvote")
#     expect(page).to have_content("0 downvotes")
#   end
#
#   scenario "authenitcated user can change a vote on a review" do
#     sign_in(user1)
#     visit theater_path(theater)
#
#     click_button "Upvote"
#     expect(page).to have_content("1 upvote")
#
#     click_button "Downvote"
#
#     expect(page).to_not have_content("1 upvote")
#     expect(page).to have_content("1 downvote")
#   end
#
#   scenario "vote counter will not increase when voted twice" do
#     sign_in(user1)
#     visit theater_path(theater)
#
#     click_button "Upvote"
#     click_button "Upvote"
#
#     expect(page).to have_content("1 upvote")
#     expect(page).to_not have_content("2 upvotes")
#   end
#
#   scenario "unauthenticated user cannot vote" do
#     visit theater_path(theater)
#
#     click_button "Upvote"
#
#     expect(page).to_not have_content("1 upvote")
#     expect(page).to_not have_content("2 upvotes")
#     expect(page).to have_content("Please log in to use this feature")
#     expect(page).to have_content("Log in")
#   end
# end
