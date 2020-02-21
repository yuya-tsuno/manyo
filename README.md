#万葉課題

##テーブル設計

tasks_table
>id: integer  
>limit: date  
>status: intger (0:未着手, 1:着手中, 2:完了)  
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
