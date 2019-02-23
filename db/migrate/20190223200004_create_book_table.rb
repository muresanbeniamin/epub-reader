class CreateBookTable < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :link
      t.integer :pages_per_day, default: 10
      t.integer :current_reading_page, default: 1
      t.timestamps
    end
  end
end
