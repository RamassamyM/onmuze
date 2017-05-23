class CreatePerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :performances do |t|
      t.references :user, foreign_key: true
      t.string :category
      t.string :name
      t.text :description
      t.string :address
      t.string :youtube_url
      t.string :facebook_url
      t.string :instagram_url
      t.string :soundcloud_url

      t.timestamps
    end
  end
end
