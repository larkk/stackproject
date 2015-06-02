class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy

	validates :text, :title, presence: true
	validates :title, length: { minimum: 10, maximum: 255 }, uniqueness: true

	
end
