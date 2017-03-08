require "rails_helper"

feature "user can review a theater" do
  let!(:user1) { FactoryGirl.create(:user, role: 'member') }
  let!(:user2) { FactoryGirl.create(:user, role: 'member') }
  let!(:theater) { FactoryGirl.create(:theater, user: user1) }

  scenario "authenitcated user adds new review successfully" do
    sign_in(user1)
    visit theater_path(theater)

    expect(page).to have_content("New Review")

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"

    expect(page).to have_content(user1.first_name)
    expect(page).to have_content("this is a review")
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

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"
    click_link "Delete Review"

    expect(page).to_not have_content("this is a review")
  end

  scenario "authenitcated user cannot delete or edit anothers review" do
    Review.create(body: "this is a review", user: user1, theater: theater)
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
end
