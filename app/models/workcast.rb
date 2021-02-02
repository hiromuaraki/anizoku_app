#アニメと声優を管理する中間テーブル
class Workcast < ApplicationRecord
  belongs_to :work
  belongs_to :cast
end
