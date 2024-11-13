class RemoveDesciptionFromTeas < ActiveRecord::Migration[7.1]
  def change
    remove_column :teas, :desciption, :string
  end
end
