###How to files issue requests

* New issue in your own repo, top right corner
* What are you trying to do?
* User Story
* What you're doing in the code (methods, relationships, end ouput)
* What do ou expect to happen?

* starting an rMVC
* 2 - routes
* 1 - Model
* 4 - Views
* 3 - Controller

self.joins

rails g migration CreateFriendships
* user has_many through: :friends
* t.references :user
* t.references :friend
* t.timestamps
rake db:migrate
rails dbconsole
\d friendships
\q
touch app/models/friendship.rb
`class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User"


end`

user model: has_many :friendships
has_many :friends, through: :friendships