class Work < ApplicationRecord
  #アニメとタグを紐付ける
  has_many :worktags, dependent: :destroy
  has_many :tags, through: :worktags

  YEAR_LIST = 2020..(Time.now.year)
  
  #アニメと声優情報を紐付ける
  has_many :workcasts, dependent: :destroy
  has_many :casts, through: :workcasts
  has_many :characters, dependent: :destroy
  has_many :series,     dependent: :destroy
  has_many :staffs,     dependent: :destroy
  
  scope :where_array, ->(work_id) { where(id: work_id) }
  scope :where_season, ->(season, year) do
    season ? where(season_year: year) : where(season_name_text: year)
  end

  #今期のアニメのwork_idを取得する
  def self.content_this_term_list
    year = self.this_term
    current_season = self.current_season
    works_ids = where_season(false, year_join_nen(year) + current_season).ids
  end

  #現在年から2010年まで年数を取得する
  def self.year_list
    YEAR_LIST.to_a
  end

  #現在年を返す
  def self.this_term
    Time.now.year
  end

  #season_name_text検索時の加工のため年を連結する
  def self.year_join_nen(year)
    year.to_s + "年"
  end 

  #現在の季節を返す
  def self.current_season
    current_month = Time.now.month
    case current_month
      when 1, 2, 3 then
        current_season = "冬"
      when 4, 5, 6 then
        current_season = "春"
      when 7, 8, 9 then
        current_season = "夏"
      when 10, 11, 12 then
        current_season = "秋"
    end
  end 
end
