class Work < ApplicationRecord
  #アニメとタグを紐付ける
  has_many :worktags, dependent: :destroy
  has_many :tags, through: :worktags

  #アニメと声優情報を紐付ける
  has_many :workcasts, dependent: :destroy
  has_many :casts, through: :workcasts

  has_many :characters, dependent: :destroy
  has_many :series,     dependent: :destroy
  has_many :seasons
  has_many :staffs,     dependent: :destroy
end
