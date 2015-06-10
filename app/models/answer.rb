class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	validates :user, :question, presence: true
	validates :text, length: { minimum: 10, maximum: 1000 }

end
