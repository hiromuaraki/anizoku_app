#アニメとタグを管理する中間テーブル
class Worktag < ApplicationRecord
  belongs_to :work
  belongs_to :tag

  #後から共通化する
  scope :worktags_ids, ->(tag, work_id) do
    tag ? where(work_id: work_id).pluck(:tag_id) : where(work_id: work_id).pluck(:work_id)
  end

  #ID一覧の中で管理人のおすすめを持っているwork_idを取得しくる
  def self.admin_recommended_list_work_id(year_search=nil)
    year = !year_search.nil? ? Work.year_list : ""
    work_ids = !year.blank? ? Work.where_season(true, year).ids : Work.eager_load_worktags_ids(Tag.tag_id[:admin_recommended])
    return work_ids if year.blank?
    return Worktag.tag_include Tag.tag_id[:admin_recommended], work_ids
  end

  #各タグ情報を持っているwork_idsを取得してくる
  def self.get_work_tag_ids(tag_id)
    work_ids = Work.limit_work_ids(tag_id)
  end

  #渡されたtag_idからwork_tagsのwork_id一覧を返す
  def self.where_worktags_work_ids(tag_id, work_ids)
    Worktag.where(tag_id: tag_id).worktags_ids(false, work_ids)
  end

  #ランダムにした作品リストを返す
  def self.items_list_shuffle(items)
    items.shuffle
  end

  #渡されたタグIDのwork_idを返す
  def self.tag_include(tag_id, work_ids)
    Worktag.where(tag_id: tag_id, work_id: work_ids).pluck(:work_id)
  end

end
