class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.string :image
      t.string :english
      t.string :korean
      t.string :chinese
      t.string :japanese

      t.timestamps null: false
    end
  end
end
