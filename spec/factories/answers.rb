FactoryGirl.define do
  factory :answer, class: 'Answer' do
    text 'blahblahblah'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    text 'other blahblah'
    question
    user
  end

  factory :a_trash, class: 'Answer' do
    text nil
    question
    user
  end

  factory :polymorfic_answer, class: 'Answer' do
    sequence(:body) { |n| "Answer_Body-#{n}" }
    question
    user
  end
end