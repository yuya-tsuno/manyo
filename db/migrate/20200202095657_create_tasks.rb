class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.date :limit
      t.integer :priority, null: false, limit: 1
      t.string :status, default: '未着手'
      t.integer :user_id
      #TODO 後ほど新しいmigrationファイルでuser_idにnull: falseを追加します。

      t.timestamps
    end
  end
end
