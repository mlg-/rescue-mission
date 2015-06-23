require 'rails_helper'

feature 'User can post a question', %Q{
  As a user
I want to post a question
So that I can receive help from others
} do

  scenario 'visitor tries to submit a question' do
    visit '/questions/new'

    expect(page).to have_content('Submit a New Question')
    fill_in('Your question', with: "How does Rails even? aka Magic Deciphering")
    fill_in('More details', with: "Wayfarers chillwave Truffaut small batch fashion axe. Cold-pressed bespoke photo booth biodiesel craft beer. Freegan narwhal aesthetic food truck wolf shabby chic. Cornhole fixie cold-pressed, Pinterest Marfa meh Intelligentsia. Flexitarian listicle Pinterest Bushwick, small batch pickled bespoke pop-up skateboard stumptown mustache organic Pitchfork chillwave meggings. Keytar quinoa drinking vinegar semiotics. Drinking vinegar semiotics fixie sustainable keytar butcher.")
    click_button("Ask Your Question!")

    expect(page).to have_content("Your question has been added.")
  end

  scenario 'visit tries to submit a question with no description' do
    visit '/questions/new'
    expect(page).to have_content('Submit a New Question')
    fill_in('Your question', with: "How does Rails even? aka Magic Deciphering")
    click_button("Ask Your Question!")

    expect(page).to have_content("Body is too short (minimum is 150 characters)")
  end

end
