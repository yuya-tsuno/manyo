class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.date :limit
      t.integer :priority, default: 1, limit: 1
      t.integer :status, default: 0, limit: 1
      #To do 後ほどuserテーブルの外部キーを別migrationファイルにて作成

      t.timestamps
    end
  end
end
