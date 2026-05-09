class CreateContactMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email
      t.string :message_type
      t.text :body
      t.integer :tool_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
