class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :message
      t.text :eventpage_url
      t.text :picture_url
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
