require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :session_token, :username, :password, :pass_hash
  validates :username, uniqueness: true

  def password=(password)
    self.pass_hash = BCrypt::Password.create(password)
  end

  def pass_check
    @check ||= BCrypt::Password.new(pass_hash)
  end


  def reset_session!
    random = SecureRandom.urlsafe_base64
    until User.find_by_session_token(random).nil?
      random = SecureRandom.urlsafe_base64
    end
    self.session_token = random
    self.save!
    random
  end
end
