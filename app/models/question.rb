class Question < ActiveRecord::Base
	has_many :answers

	validates_presence_of :title, :text
	validates_length_of :title, :minimum => 10, :maximum => 255
	validates_uniqueness_of :title
	

end
