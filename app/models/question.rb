class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments

  validates :title, :body, :user_id, presence: true

  accepts_nested_attributes_for :attachments
end
