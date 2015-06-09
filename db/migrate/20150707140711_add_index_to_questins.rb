class AddIndexToQuestins < ActiveRecord::Migration
  def change
  	add_reference :questions, :users, index: true
  	add_reference :answers, :users, index: true
  end
end
