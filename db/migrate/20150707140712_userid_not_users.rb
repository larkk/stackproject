class UseridNotUsers < ActiveRecord::Migration
  def change
  	rename_column("answers", "users_id", "user_id")
  	rename_column("questions", "users_id", "user_id")
  end
end
