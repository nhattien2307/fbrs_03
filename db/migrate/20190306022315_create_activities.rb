class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.string :action
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
