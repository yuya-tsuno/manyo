# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

users table: 
{name: string, password: string, password_digest}

tasks table:
{content: text, limit: date, priority: integer, status: string, user_id: integer, label_id:integer}

labels table
{content: string, task_id: integer}


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# manyo
