class AddStatusToSuggests < ActiveRecord::Migration[5.2]
  def change
    add_column :suggests, :status, :integer, default: 0
  end
end
