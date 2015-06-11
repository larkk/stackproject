FactoryGirl.define do

  sequence :title do |n|
    "MyTitle#{n}"
  end

  factory :question do
    title
    text "Mytext in question"
    user
  end

  factory :question1, class: 'Question' do
    title
    text "Other text"
    user
  end

  factory :invalid_question, class: Question do
    title nil
    text nil
  end
end