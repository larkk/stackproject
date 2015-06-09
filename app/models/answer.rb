class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	validates :text, presence: true, length: { minimum: 10, maximum: 1000 }

end
