require 'rails_helper'


feature 'User can post a question', %Q{
  As a user
I want to post a question
So that I can receive help from others
} do

  scenario 'visitor tries to submit a question' do
    visit '/questions/new'

    expect(page).to have_content('Submit a Question')
  end
end
