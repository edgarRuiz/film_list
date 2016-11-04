class AddUsersToMovie < ActiveRecord::Migration
  def change
    add_reference :movies, :user, foreign_key: true
  end
end
