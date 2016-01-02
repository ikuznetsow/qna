FactoryGirl.define do
  sequence :body do |n|
    "MyAnswerText #{n}"
  end

  factory :answer do
    question
		body
    user
  end
  
  factory :invalid_answer, class: 'Answer' do
    question_id nil
		body nil
    user
  end
end
