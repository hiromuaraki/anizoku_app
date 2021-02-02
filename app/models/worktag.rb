#アニメとタグを管理する中間テーブル
class Worktag < ApplicationRecord
  belongs_to :work
  belongs_to :tag
end
