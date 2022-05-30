class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.references :target, foreign_key: { to_table: :users }
      t.references :reviewer, foreign_key: { to_table: :users }
      t.references :hug, null: false, foreign_key: true

      t.timestamps
    end
  end
end
