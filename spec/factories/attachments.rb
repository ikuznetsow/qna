FactoryGirl.define do
  factory :attachment do
    association :attachable, factory: :question
    file { File.open("#{Rails.root}/public/robots.txt") }
  end
end