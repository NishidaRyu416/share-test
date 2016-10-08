class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.references :user, index: true
      t.references :word, index: true
      t.timestamps null: false
      t.index [:user_id, :word_id], unique: true
    end
  end
end
