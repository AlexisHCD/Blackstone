class CreateFeaturedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :featured_items do |t|
      t.references :tool, null: false, foreign_key: true
      t.date :featured_on

      t.timestamps
    end
    
    add_index :featured_items, [:tool_id, :featured_on], unique: true
  end
end
