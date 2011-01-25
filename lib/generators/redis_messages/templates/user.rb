class <%= user_class_name %> < ActiveRecord::Base
  has_many :<%= message_plural_name %>
  
  def inbox
    <%= message_singular_name %>_ids = <%= redis_constant_name %>.smembers(<%= message_class_name %>.inbox_for(self.username))
    <%= message_class_name %>.where(:visible => true, :id => <%= message_singular_name %>_ids).order("created_at DESC")
  end
  
  def outbox
    self.<%= message_plural_name %>(:visible => true)
  end
end