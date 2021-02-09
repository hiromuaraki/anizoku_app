class User < ApplicationRecord
  VALID_EMAIL_RAGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_one :user_profile, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_RAGEX }
  has_secure_password
end
