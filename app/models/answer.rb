class Answer < ActiveRecord::Base
	belongs_to :question

	validates_presence_of :text
	validates_length_of :text, :minimum => 10, :maximum => 1000

	


end
