

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, uniqueness: true
  before_validation(:ensure_token)
  attr_reader :password
  has_many :sub, foreign_key: :moderator_id
  has_many :posts

  def self.find_by_creds(username, pw)
    user = User.find_by(username: username)
    if user && user.is_password?(pw)
      user
    else
      nil
    end
  end


  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def ensure_token
    unless self.session_token
      self.session_token = SecureRandom.urlsafe_base64
    end
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end


end
