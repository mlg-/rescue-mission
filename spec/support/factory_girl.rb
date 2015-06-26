require 'factory_girl'

FactoryGirl.define do
  factory :user do
  	id 1
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :question do
    id 1
  	title "How does Rails even? aka Magic Deciphering"
  	body "Wayfarers chillwave Truffaut small batch fashion axe. Cold-pressed bespoke photo booth biodiesel craft beer. Freegan narwhal aesthetic food truck wolf shabby chic. Cornhole fixie cold-pressed, Pinterest Marfa meh Intelligentsia. Flexitarian listicle Pinterest Bushwick, small batch pickled bespoke pop-up skateboard stumptown mustache organic Pitchfork chillwave meggings. Keytar quinoa drinking vinegar semiotics. Drinking vinegar semiotics fixie sustainable keytar butcher."
  	user_id 1
  end

  factory :answer do
    description "Derrida uses the term ‘postdialectic material theory’ to denote the role of the observer as artist. Therefore, the subject is interpolated into a dialectic desublimation that includes sexuality as a whole.
        Debord uses the term ‘conceptual feminism’ to denote the genre, and hence the dialectic, of subcapitalist sexual identity. But Lacan’s critique of dialectic desublimation implies that the establishment is fundamentally dead, but only if culture is interchangeable with art; if that is not the case, we can assume that language is capable of intentionality."
    user_id 1
    question_id 1
  end


end
