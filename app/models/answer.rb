class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	validates :user_id, :question, presence: true
	validates :text, length: { minimum: 10, maximum: 1000 }

  def set_best_answer
    if question.has_best_answer?
      answer = question.answers.find_by(best: true)
      answer.update_attributes(best: false)
    end
    update_attributes(best: true)
  end
end