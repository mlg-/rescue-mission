require 'rails_helper'
require 'capybara/poltergeist'

feature 'User can delete a question', %Q{
  As a user
I want to delete a question
So that I can delete duplicate questions
  } do
#     Acceptance Criteria
#
# - I must be able delete a question from the question edit page
# - I must be able delete a question from the question details page
# - All answers associated with the question must also be deleted

  scenario 'delete question from the question edit page' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = FactoryGirl.create(:question)
    visit '/questions'
    click_link("How does Rails even? aka Magic Deciphering")
    click_link("Edit this question")
    click_link("Delete this question")

    expect(page).to have_content("The question has been deleted.")
  end

  scenario 'delete question from the question details page' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = FactoryGirl.create(:question)

    visit '/questions'
    click_link("How does Rails even? aka Magic Deciphering")
    click_link("Delete this question")

    expect(page).to have_content("The question has been deleted.")
  end

  scenario 'user cannot delete another user\'s question' do
    user = FactoryGirl.create(:user, id: 2)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = FactoryGirl.create(:question)

    visit '/questions'
    click_link("How does Rails even? aka Magic Deciphering")
    click_link("Delete this question")

    expect(page).to have_content("You don't have permission to delete this question.")
   end
end
