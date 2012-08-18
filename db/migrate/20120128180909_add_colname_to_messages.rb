class AddColnameToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :mid, :string
  end
end
