class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
end
