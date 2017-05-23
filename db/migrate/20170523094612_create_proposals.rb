class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.references :performance, foreign_key: true
      t.references :event, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
