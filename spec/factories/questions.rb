FactoryGirl.define do
  sequence :title do |n|
    "TestQuestion #{n}"
  end

  factory :question do
    title
    body "TestQuestionText"
    user
  end

	factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
