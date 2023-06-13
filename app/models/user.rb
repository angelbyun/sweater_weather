class User < ApplicationRecord
  validates_presence_of :email
                        :password_digest

  validates_uniqueness_of :email

  # validates_presence_of :password, confirmation: { case_sensitive: :true }
  has_secure_password

  before_create do
    self.api_key = SecureRandom.hex(10)
  end
end
