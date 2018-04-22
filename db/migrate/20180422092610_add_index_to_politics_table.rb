class AddIndexToPoliticsTable < ActiveRecord::Migration[5.1]
  def change
    add_index :politics, :title
  end
end
