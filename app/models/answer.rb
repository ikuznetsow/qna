class Answer < ActiveRecord::Base
	validates :question_id, :body, presence: true
end
