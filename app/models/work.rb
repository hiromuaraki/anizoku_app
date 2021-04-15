class Work < ApplicationRecord
  #アニメとタグを紐付ける
  has_many :worktags, dependent: :destroy
  has_many :tags, through: :worktags

  YEAR_LIST = 2015..(Time.current.year)
  
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

  #重複しない前方に一致したアニメデータを取得する
  scope :where_search_works, ->(key) do
    where("title LIKE ?", "%#{key}%").order(season_year: :desc)
  end

  #年代ごとのアニメ作品を取得する
  scope :group_by_season_year_list, ->(title_list) do
    select(:title,:season_year).where(title: title_list).group(
      :title,
      :season_year,
    ).order(season_year: :desc)
  end

  #今期のアニメのwork_idを取得する
  def self.content_this_term_list
    year = self.this_term
    current_season = self.current_season
    works_ids = where_season(false, year_join_nen(year) + current_season).ids
  end

  def self.eager_load_worktags_ids(tag_id)
    Work.includes(:worktags).where(worktags: {tag_id: tag_id}).ids
  end

  def self.limit_work_ids(tag_id)
    Work.eager_load(:worktags).where(worktags: {tag_id: tag_id}).order(season_year: :desc).ids
  end

  #現在年から2020年まで年数を取得する
  def self.year_list
    YEAR_LIST.to_a
  end

  #現在年を返す
  def self.this_term
    Time.current.year
  end

  #season_name_text検索時の加工のため年を連結する
  def self.year_join_nen(year)
    year.to_s + "年"
  end

  #重複した要素を取り除き返す
  def self.elements_uniq!(items)
    items.uniq!
  end

  #現在の季節を返す
  def self.current_season
    current_month = Time.current.month
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

  #入力されたキーワードを空白ごとに分割した結果を返す
  def self.keywords_split(keywords)
    keywords.split(/[[:blank:]]+/)
  end

end
