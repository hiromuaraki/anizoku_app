class Series < ApplicationRecord
  #シリーズとアニメを紐付ける
  has_many :work_series, dependent: :destroy
  has_many :works, through: :work_series 
end
