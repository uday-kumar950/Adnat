class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_reference :users, :organisation, foreign_key: true
  end
end
