class CreateFavoriteTools < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_tools do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true

      t.timestamps
    end
  end
end
