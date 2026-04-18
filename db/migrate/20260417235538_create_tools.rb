class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.text :description
      t.string :website_url
      t.string :slug
      t.boolean :open_source
      t.boolean :free_tier
      t.string :platform
      t.string :level
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
