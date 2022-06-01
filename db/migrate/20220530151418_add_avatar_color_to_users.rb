class AddAvatarColorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_color, :string, default: '#3D3D3D'
  end
end
