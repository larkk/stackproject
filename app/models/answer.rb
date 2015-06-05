class Answer < ActiveRecord::Base
	belongs_to :question

	validates :text, presence: true, length: { minimum: 5, maximum: 1000 }

end
