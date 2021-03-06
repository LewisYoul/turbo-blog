class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :summary
      t.text :body
      t.text :parsed_body

      t.timestamps
    end
  end
end
