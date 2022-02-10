class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 3}
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
