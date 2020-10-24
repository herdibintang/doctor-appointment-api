require 'bcrypt'

class User < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true, presence: true

  has_secure_password

  has_many :appointments
end
