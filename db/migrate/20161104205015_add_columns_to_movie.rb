class AddColumnsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :release_date, :string
    add_column :movies, :director, :string
    add_column :movies, :poster, :string
    add_column :movies, :runtime, :string
    add_column :movies, :genre, :string
    add_column :movies, :rated, :string
    add_column :movies, :plot, :string
    rename_column :movies, :movie_name, :title

  end
end