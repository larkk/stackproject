FactoryGirl.define do

  sequence :title do |n|
    "MyTitle#{n}"
  end

  factory :question do
    title
    text "MyText"
    user
  end

  factory :other_question, class: 'Question' do
    title
    body "Other text"
    user
  end

  factory :invalid_question, class: Question do
    title nil
    text nil
  end
end