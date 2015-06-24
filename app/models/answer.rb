class Answer < ActiveRecord::Base
  belongs_to :question

  validates :description, presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  validates :question_id, presence: true
end