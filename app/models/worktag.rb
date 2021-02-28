#アニメとタグを管理する中間テーブル
class Worktag < ApplicationRecord
  belongs_to :work
  belongs_to :tag

  #後から共通化する
  scope :tag_ids, ->(work_id) { where(work_id: work_id).pluck(:tag_id)}

  def initialize(work_id)
    @work_tags = work_id
  end
  
end
