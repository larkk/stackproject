class Question < ActiveRecord::Base
	has_many :answers

    after_save :touch_question

	validates_presence_of :title, :text
	validates_length_of :title, :minimum => 10, :maximum => 255
	validates_uniqueness_of :title
	
	  def touch_question
      question.touch
    end

end
