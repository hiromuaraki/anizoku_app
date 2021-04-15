class Cast < ApplicationRecord
  has_many :workcasts
  has_many :works, through: :workcasts, dependent: :destroy

  has_many :characters

end
