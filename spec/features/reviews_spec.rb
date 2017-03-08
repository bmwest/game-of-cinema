require "rails_helper"


feature "user can review a theater" do
  scenario "authenitcated user adds new review successfully" do
    user = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    visit theater_path(theater)
    expect(page).to have_content("New Review")

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"

    expect(page).to have_content(user.first_name)
    expect(page).to have_content("this is a review")
  end

  scenario "authenitcated user submits invalid review" do
    user = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    visit theater_path(theater)

    click_button "Add Review"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("this is a review")
  end


  scenario "unauthenitcated user attempts to submit review" do
    user = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    click_link "Sign Out"
    visit theater_path(theater)

    click_button "Add Review"
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("Please log in to use this feature")
    expect(page).to have_content("Log in")
    expect(page).to_not have_content(theater.name)
  end

  scenario "Review owner can delete review" do
    user = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    visit theater_path(theater)

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"
    click_link "Delete Review"

    expect(page).to_not have_content("this is a review")
  end

  scenario "authenitcated user cannot delete or edit anothers review" do
    user1 = FactoryGirl.create(:user, role: 'member')
    user2 = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user1)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    visit theater_path(theater)

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"
    click_link "Sign Out"

    click_link "Sign In"
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_button "Sign In"

    visit theater_path(theater)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Review")
  end

  scenario "un-authenitcated user cannot delete or edit review" do
    user = FactoryGirl.create(:user, role: 'member')
    theater = FactoryGirl.create(:theater, user: user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "Add New Theater"

    fill_in 'Name', with: theater.name
    fill_in 'Address', with: theater.address
    fill_in 'City', with: theater.city
    fill_in 'State', with: theater.state
    fill_in 'Zip', with: theater.zip

    click_button "Add Theater"
    visit theater_path(theater)

    fill_in 'New Review', with: "this is a review"
    click_button "Add Review"
    click_link "Sign Out"

    visit theater_path(theater)

    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete Review")
  end
end
