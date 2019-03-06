class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.text :content
      t.integer :quanlity
      t.integer :number_page
      t.string :author
      t.string :publisher
      t.datetime :publish_date
      t.float :avg_rate

      t.timestamps
    end
  end
end
