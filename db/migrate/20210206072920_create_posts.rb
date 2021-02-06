class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :post_image
      t.text :text
      t.integer :place
      t.integer :genre

      t.timestamps
    end
  end
end
