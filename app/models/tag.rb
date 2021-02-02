class Tag < ApplicationRecord
  has_many :worktags, dependent: :destroy
  has_many :works, through: :worktags
end
