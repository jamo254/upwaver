class AddFullNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :from, :string
    add_column :users, :about, :text
    add_column :users, :language, :string
    add_column :users, :status, :boolean, default: false
  end
end
