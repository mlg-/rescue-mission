require 'rails_helper'

feature 'User can answer a question', %Q{
  As a user
I want to answer another user's question
So that I can help them solve their problem
} do
#   Acceptance Criteria
#
# - I must be on the question detail page
# - I must provide a description that is at least 50 characters long
# - I must be presented with errors if I fill out the form incorrectly
  scenario 'user answers a question' do

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

    fill_in('Your Answer', with: "The main theme of the works of Fellini is the difference between society and culture. Therefore, if subcapitalist textual theory holds, we have to choose between surrealism and the neomodern paradigm of narrative. Sontag’s essay on Batailleist `powerful communication’ holds that sexuality is used to oppress the underprivileged.")
    click_button("Save the day!")

    expect(page).to have_content("The main theme of the works of Fellini is the difference between society and culture. Therefore, if subcapitalist textual theory holds, we have to choose between surrealism and the neomodern paradigm of narrative. Sontag’s essay on Batailleist `powerful communication’ holds that sexuality is used to oppress the underprivileged.")

  end

  scenario 'user tries to answer a question with a too-short description' do
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

    fill_in('Your Answer', with: "bloop")
    click_button("Save the day!")

    expect(page).to have_content("Description is too short (minimum is 50 characters)")

  end

end
