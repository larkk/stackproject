FactoryGirl.define do
  factory :answer, class: 'Answer' do
    text 'blahblahblah'
    question
    user
  end

  factory :other_answer, class: 'Answer' do
    text 'other blahblah'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    text 'blahblah'
    question
    user
  end

  factory :polymorfic_answer, class: 'Answer' do
    sequence(:text) { |n| "Answer_text-#{n}" }
    question
    user
  end
end