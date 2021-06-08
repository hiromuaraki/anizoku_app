class Cast < ApplicationRecord
  has_many :workcasts, dependent: :destroy
  has_many :works, through: :workcasts

  has_many :characters

end
