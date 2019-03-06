class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.string :name_book
      t.string :author
      t.string :publisher
      t.integer :number_page
      t.string :category

      t.timestamps
    end
  end
end
