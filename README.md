#テーブル設計
***

##User
**association**
~~~
has_many :books, :likes, :reviews
~~~
**table**
- avatar
- user_name
- email
- password
- first_name
- last_name
- phone_number
- postal_code
- street_adress

##Book
**association**
~~~
has_many :likes, :reviews
belongs_to :user
~~~
**table**
- image
- title
- content
- state
- price
- postage
- user_id
- likes_count

##Like
**association**
~~~
belongs_to :user, :book
~~~
**table**
- user_id
- book_id

##Review
**association**
~~~
belongs_to :user, :book
~~~
**table**
- content
- rate
- user_id
- book_id
