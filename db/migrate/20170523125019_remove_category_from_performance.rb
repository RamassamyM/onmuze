class RemoveCategoryFromPerformance < ActiveRecord::Migration[5.0]
  def change
    remove_column :performances, :category, :string
  end
end
