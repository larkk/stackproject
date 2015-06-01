class Answer < ActiveRecord::Base
	belongs_to :question

    after_save :touch_answer

	validates_presence_of :text
	validates_length_of :text, :minimum => 10, :maximum => 1000

	def touch_answer
      answer.touch
    end


end
