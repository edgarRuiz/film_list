class CreateListUsers < ActiveRecord::Migration
  def change
    create_table :list_users do |t|
      t.string :list_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
