FactoryGirl.define do
  sequence :title do |n|
    "TestQuestion #{n}"
  end

  factory :question do
    title
    body "TestQuestionText"
    user
  
    trait :with_attachment do
      after(:create) do |question|
        question.attachments << create(:attachment)
      end
    end
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user
  end
end
