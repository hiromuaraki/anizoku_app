class Work < ApplicationRecord
  #アニメとタグを紐付ける
  has_many :worktags, dependent: :destroy
  has_many :tags, through: :worktags
  
  #アニメと声優情報を紐付ける
  has_many :workcasts, dependent: :destroy
  has_many :casts, through: :workcasts
  
  #レビュー情報と紐付ける
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  
  #アニメとシリーズを紐付ける
  has_many :work_series, dependent: :destroy
  has_many :series, through: :work_series
  
  #視聴ステータスを紐付ける
  has_many :watches, dependent: :destroy
  has_many :users, through: :watches
  
  #マイリストを紐づける
  has_many :mylists,dependent: :destroy
  has_many :users, through: :mylists
  
  has_many :characters, dependent: :destroy
  has_many :staffs,     dependent: :destroy
  
  YEAR_LIST = 2015..(Time.current.year)
  
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

  scope :work_id_group_by_season_year_list, ->(work_ids) do
    select(:title,:season_year, :season_name_text).where(id: work_ids).group(
      :title,
      :season_year,
      :season_name_text
    ).order(season_name_text: :desc)
  end

  #必要ん最小限のフィールドのみ取得
  scope :works_select, ->(work_ids) do
    select(
      :id,
      :facebook_og_image_url,
      :title,
      :season_year,
      :season_name_text,
      :wikipedia_url,
      :media_text,
      :created_at,
      :updated_at
    ).where(id: work_ids).order(season_year: :desc, season_name_text: :asc)
  end

  #今期のアニメのwork_idを取得する
  def self.content_this_term_list(mode=nil)
    year = self.this_term
    current_season = mode.nil? ? self.current_season : self.current_season("前期")
    works_ids = where_season(false, year_join_nen(year) + current_season).ids
  end

  def self.content_next_term_list
    year = self.this_term
    current_season = self.next_season
    works_ids = where_season(false, year_join_nen(year) + current_season)&.ids
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

  #現在/前期の季節を返す
  def self.current_season(mode=nil)
    current_month = mode.nil? ? Time.current.month : self.before_season
    case current_month
      when 1, 2, 3 then "冬"
      when 4, 5, 6 then "春"
      when 7, 8, 9 then "夏"
      when 10, 11, 12 then "秋"
    end
  end

  #3ヶ月前の「月」を返す
  def self.before_season
    month_ago = Time.now - 3.month
    month_ago.month
  end

  #来期の季節を返す
  def self.next_season
    next_month = Time.current.month + 1 == 13 ? 1 : Time.current.month + 1
    case next_month
      when 1, 2, 3 then "冬"
      when 4, 5, 6 then "春"
      when 7, 8, 9 then "夏"
      when 10, 11, 12 then "秋"
    end
  end

  #入力されたキーワードを空白ごとに分割した結果を返す
  def self.keywords_split(keywords)
    keywords.split(/[[:blank:]]+/)
  end

end
