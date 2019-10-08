class CreateBookPages < ActiveRecord::Migration[5.2]
  def change
    create_table :book_pages do |t|
      t.references :book
      t.string :content
      t.timestamps
    end
  end
end
