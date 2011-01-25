class User < ActiveRecord::Base
  has_many :messages
  
  def inbox
    message_ids = R.smembers(Message.inbox_for(self.username))
    Message.where(:visible => true, :id => message_ids).order("created_at DESC")
  end
  
  def outbox
    self.messages(:visible => true)
  end

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  def inbox
    message_ids = R.smembers(Message.inbox_for(self.username))
    Message.where(:visible => true, :id => message_ids).order("created_at DESC")
  end
  
  def outbox
    self.messages(:visible => true)
  end


  # login can be either username or email address
  def self.authenticate(params)
    login = params[:login]
    conditions = ['username = ? or email = ?', login, login]
    user = User.where(conditions).first
    return user if user && user.matching_password?(params[:password])
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  

end
