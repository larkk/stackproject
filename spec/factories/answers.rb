FactoryGirl.define do
  factory :answer do
    text 'MyAnswer'
    question
  end
  factory :invalid_answer, class: 'Answer' do
   text nil
  end
end
