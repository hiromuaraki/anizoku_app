#アニメとタグを管理する中間テーブル
class Worktag < ApplicationRecord
  belongs_to :work
  belongs_to :tag

  YEAR_LIST = 2020..(Time.now.year)

  #後から共通化する
  scope :worktags_ids, ->(tag, work_id) do
    tag ? where(work_id: work_id).pluck(:tag_id) : where(work_id: work_id).pluck(:work_id)
  end

  #ID一覧の中で管理人のおすすめを持っているwork_idを取得しくる
  def self.admin_recommended_list_work_id
    year = self.time_year
    work_ids = Work.where(season_year: year).ids
    work_tag_ids = Worktag.where(tag_id: Tag.tag_id[:admin_recommended]).worktags_ids(false, work_ids)
  end

  #ランダムにした作品リストを返す
  def self.items_list_shuffle(items)
    items.shuffle
  end

  #現在年から2010年まで年数を取得する
  def self.time_year
    YEAR_LIST.to_a
  end
  
end
