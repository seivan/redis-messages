Feature: Redis Messages Generator
  In order to send messages to multiple users
  As a rails developer
  I want to generate a messaging library

  Scenario: Generate default messages
    Given a new Rails app
    When I run "rails g redis_messages"
    Then I should see the following files
       | app/models/message.rb          |
     # | app/helpers/messages_helper.rb |
       | db/migrate                     |
	And I should see "class Message < ActiveRecord::Base" in file "app/models/message.rb"
	And I should see "belongs_to :user" in file "app/models/message.rb"
  
 	And I should see "def recievers" in file "app/models/message.rb"
	And I should see "R.smembers(Message.receivers_for(self.id))" in file "app/models/message.rb"
  	And I should see "end" in file "app/models/message.rb"
	And I should see "def send_to(receivers_usernames)" in file "app/models/message.rb"
    And I should see "receivers_usernames.each do |username|" in file "app/models/message.rb"
	And I should see "R.sadd(Message.inbox_for(username), self.id)" in file "app/models/message.rb"
    And I should see "R.sadd(Message.receivers_for(self.id), username)" in file "app/models/message.rb"
	And I should see "end" in file "app/models/message.rb"
	And I should see "end" in file "app/models/message.rb"
  
  	And I should see "def self.inbox_for(username)" in file "app/models/message.rb"
  	And I should see "("message:#{username}:inbox")" in file "app/models/message.rb"
  	And I should see "end" in file "app/models/message.rb"
  
  	And I should see "def self.receivers_for(message_id)" in file "app/models/message.rb"
  	And I should see "("message:#{message_id}:receivers")" in file "app/models/message.rb"
  	And I should see "end" in file "app/models/message.rb"
  	And I should see "end" in file "app/models/message.rb"
	
	And I should see the following files
		|app/models/user.rb|
	And I should see "class User < ActiveRecord::Base" in file "app/models/user.rb"
	And I should see "has_many :messages" in file "app/models/user.rb"
	And I should see "def inbox" in file "app/models/user.rb"
	And I should see "message_ids = R.smembers(Message.inbox_for(self.username))" in file "app/models/user.rb"
	And I should see "Message.where(:visible => true, :id => message_ids).order("created_at DESC")" in file "app/models/user.rb"
	And I should see "end" in file "app/models/user.rb"
	And I should see "def outbox" in file "app/models/user.rb"
	And I should see "self.messages(:visible => true)" in file "app/models/user.rb"
	And I should see "end" in file "app/models/user.rb"
	And I should see "end" in file "app/models/user.rb"
	And I should not see file "temp_file.rb"

