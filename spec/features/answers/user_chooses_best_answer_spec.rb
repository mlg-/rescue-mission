require 'rails_helper'

feature 'User can choose the best answer to a question', %Q{
  As a user
I want to mark an answer as the best answer
So that others can quickly find the answer
} do
#   Acceptance Criteria
#
# - I must be on the question detail page
# - I must be able mark an answer as the best
# - I must see the "best" answer above all other answers in the answer list
  scenario 'User successfully chooses an answer from multiple for a question' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = Question.create!(title: "How does Rails even? aka Magic Deciphering", 
                body: "Wayfarers chillwave Truffaut small batch fashion axe. Cold-pressed bespoke photo booth biodiesel craft beer. Freegan narwhal aesthetic food truck wolf shabby chic. Cornhole fixie cold-pressed, Pinterest Marfa meh Intelligentsia. Flexitarian listicle Pinterest Bushwick, small batch pickled bespoke pop-up skateboard stumptown mustache organic Pitchfork chillwave meggings. Keytar quinoa drinking vinegar semiotics. Drinking vinegar semiotics fixie sustainable keytar butcher.")

    answer_1 = Answer.create!(description: "The main theme of the works of Fellini is the difference between society and culture. Therefore, if subcapitalist textual theory holds, we have to choose between surrealism and the neomodern paradigm of narrative. Sontag’s essay on Batailleist `powerful communication’ holds that sexuality is used to oppress the underprivileged.",
        user_id: user.id,
        question_id: question.id)
    answer_2 = Answer.create!(description: "Derrida uses the term ‘postdialectic material theory’ to denote the role of the observer as artist. Therefore, the subject is interpolated into a dialectic desublimation that includes sexuality as a whole.
        Debord uses the term ‘conceptual feminism’ to denote the genre, and hence the dialectic, of subcapitalist sexual identity. But Lacan’s critique of dialectic desublimation implies that the establishment is fundamentally dead, but only if culture is interchangeable with art; if that is not the case, we can assume that language is capable of intentionality.",
        user_id: user.id,
        question_id: question.id)
    visit "/questions/#{question.id}"

    click_button("button-#{answer_2.id}")

    expect(page).to have_content("Best Answer #{answer_2.description}")
    expect(page.body.index(answer_2.description)).to be < page.body.index(answer_1.description)

  end

  scenario 'user cannot choose best answer for another user\'s question' do
    user = FactoryGirl.create(:user, id: 2)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    question = FactoryGirl.create(:question)
    answer = FactoryGirl.create(:answer)

    visit "/questions/#{question.id}"
    click_button("button-#{answer.id}")
  end

end
