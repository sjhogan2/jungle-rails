class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def password_length(password)
    password.length > 2
  end

  def self.authenticate_with_credentials(email, password)
    user = User.where("LOWER(email)=?", email.strip.downcase).first
    if user && user.authenticate(password)
      user
    else
      false
    end
  end
end
