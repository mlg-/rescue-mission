require 'rails_helper'

feature 'User can edit a question', %Q{
  As a user
I want to edit a question
So that I can correct any mistakes or add updates
  } do
  scenario 'User edits a question in a valid manner' do
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

    fill_in('More details', with: "In the works of Rushdie, a predominant concept is the distinction between closing and opening. The primary theme of de Selby’s[2] critique of Derridaist reading is the role of the participant as artist. However, substructural discourse states that academe is capable of significance, but only if Debord’s essay on materialist sublimation is valid; if that is not the case, Baudrillard’s model of cultural capitalism is one of “Batailleist `powerful communication'”, and hence impossible.")
    click_button("Save Changes")

    expect(page).to have_content("In the works of Rushdie, a predominant concept is the distinction between closing and opening.")
  end

  scenario 'User edits a question in an invalid manner' do
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

    fill_in('Your question', with: "bloop")
    click_button("Save Changes")

    expect(page).to have_content("Title is too short (minimum is 40 characters)")
  end

  scenario 'user tries to edit another users question' do
    user = FactoryGirl.create(:user, id: 2)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = FactoryGirl.create(:question)

    visit '/questions'
    click_link("How does Rails even? aka Magic Deciphering")
    click_link("Edit this question")
    
    expect(page).to have_content("You don't have permission to edit this question.")
  end

end
