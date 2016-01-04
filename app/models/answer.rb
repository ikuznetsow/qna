class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
	
  validates :user_id, :question_id, :body, presence: true

  default_scope { order is_best: :desc }

end
