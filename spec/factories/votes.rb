FactoryGirl.define do
  factory :vote do
    association :votable, factory: :question
    value 1
    user 
  end
end
