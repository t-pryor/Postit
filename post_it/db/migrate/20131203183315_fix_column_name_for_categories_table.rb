class FixColumnNameForCategoriesTable < ActiveRecord::Migration
  def change
    rename_column :categories, :username, :name
  end
end
