class Api::V1::SearchController < ApplicationController

  #アニメタイトル・キャラクター名を検索した結果をJSONで返す
  def index
    keywords = Work.keywords_split(params[:q])
    @search_works = Work.none
    @search_characters = []
    if keywords.size > 1
      keywords.each do |key|
        @search_works = @search_works.or(Work.where("title LIKE ?", "%#{key}%").where(is_deleted: true).order(season_year: :desc))
        @search_characters << Character.find_by("name LIKE ?", "%#{key}%")
      end    
    else
      #入力キーワードが1件時のみ
      work_title = Work.find_by(title: keywords[0])
      character_name = Character.find_by(name: keywords[0])
      #データが一致した時は曖昧検索しない
      @search_works = work_title.nil? ? Work.where_search_works(keywords[0]) : work_title
      @search_characters = character_name.nil? ? Character.where_search_characters(keywords[0]) : character_name
    end
  end

end
