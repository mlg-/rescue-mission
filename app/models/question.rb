class Question < ActiveRecord:: Base
  has_many :answers

  validates :title, presence: true, length: { minimum: 40 }
  validates :body, presence: true, length: { minimum: 150 }

  def belongs_to_user?(user)
  	return true unless self.user_id != user
  end

end
