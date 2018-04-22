class CreatePolitics < ActiveRecord::Migration[5.1]
  def change
    create_table :politics do |t|
      t.string :title
      t.text :description
      t.string :link

      t.timestamps
    end
  end
end
