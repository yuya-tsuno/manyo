class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.date :limit
      t.integer :priority
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
