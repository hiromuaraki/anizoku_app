class Cast < ApplicationRecord
  has_many :workcasts
  has_many :works, through: :workcasts, dependent: :destroy

  belongs_to :character
end
