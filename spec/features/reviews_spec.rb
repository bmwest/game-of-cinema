require "rails_helper"

feature "user can review a theater" do
  let!(:user1) { FactoryGirl.create(:user, role: 'member') }
  let!(:user2) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user1) }

  scenario "authenitcated user adds new review successfully" do
    sign_in(user1)
    visit theater_path(theater)

    expect(page).to have_content("New Review")
    expect(page).to have_content("Be the first to review this theater!")

    choose("review_rating_1")
    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"

    expect(page).to have_content(user1.first_name)
    expect(page).to have_content("this is a review")
    expect(page).to have_content("RATING : 1.0 / 5.0")
  end

  scenario "authenitcated user submits invalid review" do
    sign_in(user1)
    visit theater_path(theater)

    click_button "Add Review"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("this is a review")
  end


  scenario "unauthenitcated user attempts to submit review" do
    visit theater_path(theater)

    click_button "Add Review"
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("Please log in to use this feature")
    expect(page).to have_content("Log in")
    expect(page).to_not have_content(theater.name)
  end

  scenario "Review owner can delete review" do
    sign_in(user1)
    visit theater_path(theater)

    choose("review_rating_1")
    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"
    click_link "Delete Review"

    expect(page).to_not have_content("this is a review")
    expect(page).to have_content("Be the first to review this theater!")
  end

  scenario "Review owner can edit review" do
    Review.create(rating:3, body:"hello", theater: theater, user: user1)
    sign_in(user1)
    visit theater_path(theater)

    click_link "Edit Review"

    choose("review_rating_2")
    fill_in 'New Review', with: "this is a different review"
    click_button "Add Review"

    expect(page).to_not have_content("hello")
    expect(page).to have_content("this is a different review")

    expect(page).to_not have_content("3/5")
    expect(page).to have_content("2/5")

    expect(page).to have_content("Review was successfully updated")
  end

  scenario "authenitcated user cannot delete or edit anothers review" do
    Review.create(rating: 1, body: "this is a review", user: user1, theater: theater)
    sign_in(user2)
    visit theater_path(theater)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Review")
  end

  scenario "un-authenitcated user cannot delete or edit review" do
    visit theater_path(theater)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Review")
  end

  scenario "mulitple authenitcated users review a theater and theater rating is adjusted" do
    Review.create(rating: 1, body: "this is a review", user: user1, theater: theater)
    sign_in(user2)
    visit theater_path(theater)

    expect(page).to_not have_content("Be the first to review this theater!")
    expect(page).to have_content("RATING : 1.0 / 5.0")

    choose("review_rating_2")
    fill_in 'New Review', with: "second review"
    click_button "Add Review"

    expect(page).to have_content("RATING : 1.5 / 5.0")
  end
end
