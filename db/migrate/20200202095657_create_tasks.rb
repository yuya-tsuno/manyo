class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :limit
      t.integer :priority
      t.integer :status
      t.integer :user_id
      #TODO 後ほど新しいmigrationファイルでuser_idにnull: falseを追加します。

      t.timestamps
    end
  end
end
