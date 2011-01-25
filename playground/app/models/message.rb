class Message < ActiveRecord::Base
  belongs_to :user
  
  #You want to do this in a background job, may I recomend resque. 
  def recievers
    R.smembers(Message.receivers_for(self.id))
  end
  
  def send_to(receivers_usernames)
    receivers_usernames.each do |username|
      R.sadd(Message.inbox_for(username), self.id)
      R.sadd(Message.receivers_for(self.id), username)
    end
  end
  
  def self.inbox_for(username)
    ("message:#{username}:inbox")
  end
  
  def self.receivers_for(message_id)
    ("message:#{message_id}:receivers")
  end
end