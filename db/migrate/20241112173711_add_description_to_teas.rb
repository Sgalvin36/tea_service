class AddDescriptionToTeas < ActiveRecord::Migration[7.1]
  def change
    add_column :teas, :description, :string
  end
end
