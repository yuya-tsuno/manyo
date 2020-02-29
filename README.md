# 万葉課題

## テーブル設計

tasks_table
>id: integer  
>titile: string  
>content: text  
>limit: date  
>priority: intger
>status: string (未着手、着手中、完了)  
>user_id: integer  
>labeling_id: integer  

users_table
>id: integer  
>name: string  
>password: string  
>password_digest: string  
>admin: boolean  

labels_table
>id: integer  
>name: string  

labelings_table
>task_id: integer  
>label_id: integer  

## herokuデプロイ方法  
1. % heroku create でherokuアプリを作成  
2. % git push heroku ブランチ名:master で指定したブランチをherokuにpush  
3. % heroku run rails db:migrate でmigrateを実行（データベースは自動で作成される）  
4. % heroku open でアプリを起動