class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	belongs_to :user

	validates :text, :title, :user_id, presence: true
	validates :title, length: { minimum: 5, maximum: 255 }
	#, uniqueness: true
  def has_best_answer?
    answers.find_by(best: true) ? true : false
  end

	
end
