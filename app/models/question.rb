class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	belongs_to :user

	validates :text, :title, :user, presence: true
	validates :title, length: { minimum: 5, maximum: 255 }
	#, uniqueness: true

	
end
