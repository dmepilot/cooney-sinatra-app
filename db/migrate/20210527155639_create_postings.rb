class CreatePostings < ActiveRecord::Migration[5.2]
  def change
    create_table :postings do |t|
      t.string :title
      t.string :location
      t.string :details

      t.timestamps null: false
    end
  end
end
