class AddOwnerToRoom < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms, :owner, foreign_key: true
  end
end
