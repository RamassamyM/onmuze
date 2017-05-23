class AddGenreToPerformances < ActiveRecord::Migration[5.0]
  def change
    add_reference :performances, :genre, foreign_key: true
  end
end
