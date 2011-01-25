Feature: Redis Messages Generator With Named Models
  In order to send letters to multiple users
  As a rails developer
  I want to generate a messaging library using letters as a name


  Scenario: Generate named messages
    Given a new Rails app
    When I run "rails g redis_messages letters players Red"
    Then I should see the following files
       | app/models/letter.rb          |
     # | app/helpers/messages_helper.rb |
       | db/migrate                     |
	And I should see "class Letter < ActiveRecord::Base" in file "app/models/letter.rb"
	And I should see "belongs_to :player" in file "app/models/letter.rb"
  
	And I should see "Red.smembers(Letter.receivers_for(self.id))" in file "app/models/letter.rb"
	And I should see "Red.sadd(Letter.inbox_for(username), self.id)" in file "app/models/letter.rb"
    And I should see "Red.sadd(Letter.receivers_for(self.id), username)" in file "app/models/letter.rb"
  
  	And I should see "def self.inbox_for(username)" in file "app/models/letter.rb"
  	And I should see "("letter:#{username}:inbox")" in file "app/models/letter.rb"
  
  	And I should see "def self.receivers_for(letter_id)" in file "app/models/letter.rb"
  	And I should see "("letter:#{letter_id}:receivers")" in file "app/models/letter.rb"
	
	And I should see the following files
		|app/models/player.rb|
	And I should see "class Player < ActiveRecord::Base" in file "app/models/player.rb"
	And I should see "has_many :letters" in file "app/models/player.rb"
	And I should see "letter_ids = Red.smembers(Letter.inbox_for(self.username))" in file "app/models/player.rb"
	And I should see "Letter.where(:visible => true, :id => letter_ids).order("created_at DESC")" in file "app/models/player.rb"

	And I should see "self.letters(:visible => true)" in file "app/models/player.rb"
	And I should not see file "temp_file.rb"
