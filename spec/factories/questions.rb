FactoryGirl.define do
  factory :question do
     title 'MyQuestion'
     text 'MyText'
   end
  factory :invalid_question , class: 'Question' do
    title ''
    text 'MyText'
  end
end