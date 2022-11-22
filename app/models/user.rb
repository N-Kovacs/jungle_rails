class User < ApplicationRecord
  has_secure_password
  validates :firstname, presence: true
  validates :lastname, presence: true 
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8}
  validates :password_confirmation, presence: true
  before_save { email.downcase! }


  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end

end
