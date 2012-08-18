class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :user_id
      t.string :bg_color
      t.string :message_color

      t.timestamps
    end
  end
end
