class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :scheduled_at
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
