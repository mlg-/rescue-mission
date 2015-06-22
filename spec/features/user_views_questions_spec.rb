require 'rails_helper'

feature 'visitor views questions', %Q{
  As a user
I want to view recently posted questions
So that I can help others
} do
    # Acceptance Criteria
    #
    # - I must see the title of each question
    # - I must see questions listed in order, most recently posted first

    scenario 'visit the index page' do
        question = Question.create!(title: "How does Rails even?",
                   body: "Wut.")
        question2 = Question.create!(title: "How do I become great?",
                    body: "Ask Vikram.")

        visit '/questions'
        expect(page).to have_content("All Questions")
        expect(page).to have_content(question.title)
        expect(page.body.index(question2.title)).to be < page.body.index(question.title)
    end
end

feature 'visitor views question details', %Q{
  As a user
I want to view a question's details
So that I can effectively understand the question
} do

  # Acceptance Criteria
  #
  # - I must be able to get to this page from the questions index
  # - I must see the question's title
  # - I must see the question's description

    scenario 'click on a question' do
      question = Question.create!(title: "How does Rails even?",
                 body: "Wut.")
      visit '/questions'

      click_link(question.title)

      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)
    end

end
