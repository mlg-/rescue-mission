class Answer < ActiveRecord::Base
  belongs_to :question

  validates :description, presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  validates :question_id, presence: true

 	class << self
	  def only_one_best_answer(new_best_answer)
	  	Question.find(new_best_answer).answers.each do |answer|
	  	  if answer.best_answer == true
	  	    answer.update(best_answer: false)
	  	  end
	  	end
	  end
	end

end
