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

    visit '/questions/new'

    expect(page).to have_content('Submit a New Question')
    fill_in('Your question', with: "How does Rails even? aka Magic Deciphering")
    fill_in('More details', with: "Wayfarers chillwave Truffaut small batch fashion axe. Cold-pressed bespoke photo booth biodiesel craft beer. Freegan narwhal aesthetic food truck wolf shabby chic. Cornhole fixie cold-pressed, Pinterest Marfa meh Intelligentsia. Flexitarian listicle Pinterest Bushwick, small batch pickled bespoke pop-up skateboard stumptown mustache organic Pitchfork chillwave meggings. Keytar quinoa drinking vinegar semiotics. Drinking vinegar semiotics fixie sustainable keytar butcher.")
    click_button("Ask Your Question!")

    expect(page).to have_content("Your question has been added.")
    click_link("How does Rails even? aka Magic Deciphering")
    click_link("Edit this question")
    click_link("Delete this question")

    expect(page).to have_content("The question has been deleted.")
  end

end
