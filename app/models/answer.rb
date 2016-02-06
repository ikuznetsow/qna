class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :user_id, :question_id, :body, presence: true

  default_scope { order(is_best: :desc).order(created_at: :asc) }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
