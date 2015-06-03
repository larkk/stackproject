class Answer < ActiveRecord::Base
	belongs_to :question

	validates :text, presence: true, length: { minimum: 10, maximum: 1000 }


end
