class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :caption

      t.timestamps null: false
    end

    add_foreign_key :posts, :users
  end
end
