require 'spec_helper'
require 'rails_helper'

feature "goals" do
  before(:each) do
    User.create!(username: "Snooper McSnooperson", password: "fo drizzle")
    User.create!(username: "testing", password: "password")

    visit new_session_url
    fill_in 'Username', with: "testing"
    fill_in 'Password', with: "password"
    click_on "Sign In"

    visit new_goal_url
    fill_in 'Content', with: "This is a very good goal"
    click_on "Add a Goal"
  end

  scenario "can add goals" do
    expect(page).to have_content("This is a very good goal")
  end

  scenario "can see own goals" do
    visit new_goal_url
    fill_in 'Content', with: "Here's another great goal"
    click_on "Add a Goal"

    visit user_url(User.last)
    expect(page).to have_content("This is a very good goal")
    expect(page).to have_content("Here's another great goal")
  end

  scenario "allows you to complete goals" do
    check('Completed?')
    click_on('Submit')

    expect(page).to have_content("Complete!")
  end

  scenario "allows you to edit goals" do
    visit edit_goal_url(Goal.last)
    expect(page).to have_content("This is a very good goal")

    fill_in 'Content', with: "This is an excellent goal"
    click_on "Edit Goal"
    expect(page).to have_content("This is an excellent goal")
  end

  feature 'private goals' do
    before(:each) do
      visit new_goal_url
      fill_in 'Content', with: "Here's a private goal"
      click_on "Add a Goal"
    end

    scenario "hides private goals from other users" do
      click_on 'Sign Out'
      fill_in 'Username', with: "Snooper McSnooperson"
      fill_in 'Password', with: "fo drizzle"
      click_on "Sign In"

      visit user_url(User.last)
      expect(page).to have_content("This is a very good goal")
      expect(page).not_to have_content("Here's a private goal")
    end
  end
end
