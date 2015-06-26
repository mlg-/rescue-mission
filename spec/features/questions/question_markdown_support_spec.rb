require 'rails_helper'

feature 'User can submit with Markdown formatting', %Q{
  As a user
I want to write my questions and answers with markdown
So I can easily format my questions and answers
} do

  scenario 'user submits question with markdown that is translated to html' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit '/questions/new'

    expect(page).to have_content('Submit a New Question')
    fill_in('Your question', with: "How does Rails even? aka Magic Deciphering")
    fill_in('More details', with: "# This is a heading.\n* First code problem \n* Second code problem\n* A thing I tried\n* Burn-it-with-fire.gif\n
    Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. Yada yada other stuff. ")
    click_button("Ask Your Question!")

    click_link("How does Rails even? aka Magic Deciphering")
    
    expect(page).to have_css("h1", text: "This is a heading.")
    expect(page).to have_css("li", text: "Burn-it-with-fire.gif")
  end
end
