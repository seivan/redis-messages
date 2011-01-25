class <%= message_class_name %> < ActiveRecord::Base
  belongs_to :<%= user_singular_name %>
  
  def recievers
    <%= redis_constant_name %>.smembers(<%= message_class_name %>.receivers_for(self.id))
  end

  #You want to do this in a background job, may I recommend resque. 
  def send_to(receivers_usernames)
    receivers_usernames.each do |username|
      <%= redis_constant_name %>.sadd(<%= message_class_name %>.inbox_for(username), self.id)
      <%= redis_constant_name %>.sadd(<%= message_class_name %>.receivers_for(self.id), username)
    end
  end
  
  def self.inbox_for(username)
    ("<%= message_singular_name %>:#{username}:inbox")
  end
  
  def self.receivers_for(<%= message_singular_name %>_id)
    ("<%= message_singular_name %>:#{<%= message_singular_name %>_id}:receivers")
  end
end