class RemoveProgressFromHugs < ActiveRecord::Migration[6.1]
  def change
    remove_column :hugs, :progress
  end
end
