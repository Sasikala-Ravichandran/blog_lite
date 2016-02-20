class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :url, :string
  end
end
