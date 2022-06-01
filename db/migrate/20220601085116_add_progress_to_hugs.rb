class AddProgressToHugs < ActiveRecord::Migration[6.1]
  def change
    add_column :hugs, :progress, :integer
  end
end
