# README

任務管理系統(使用 github action for CI)

兩種身份
  1. 一般使用者(只能見看自己的任務，對自己任務 CRUD)
  2. 管理員(能夠看見所有使用者的任務清單以及任務總數，可以針對使用者做 CRUD)

建立一筆任務可以設定以下項目：
  1.任務標題
  2.優先順序(低、中、高)，可排序
  3.狀態(待處理、處理中、已完成)，可排序
  4.開始時間，可排序
  5.結束時間，可排序

Table Schema

User Table(has_many :tasks)
  1. email string
  2. password_digest string
  3. username string
  4. created_at datetime
  5. updated_at datetime
  6. role string

Task Table(belongs_to :user)
  1. user integer
  2. title string
  3. tag string
  4. priority integer
  5. state integer
  6. start_time datetime
  7. end_time datetime
  8. created_at datetime
  9. updated_at datetime

管理員帳號
  email: jerry@gmail.com
  password: 123456
