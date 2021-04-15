class CastWorksController < ApplicationController
  #キャストの出演作品一覧を表示させる
  def index
    #不正アクセス時のリクエストコード取得用のURL
    return if params[:cast_data][:cast_name].blank?
    @cast = Cast.find_by(name: params[:cast_data][:cast_name])
    cast_works_list = Cast.where(name: params[:cast_data][:cast_name]).pluck(:work_title)
    season = Work.group_by_season_year_list(cast_works_list).pluck(:season_year)
    #各年代とにグルーピングする
    @season_list = season.group_by(&:itself)
    @works = Work.select(
      :id,
      :facebook_og_image_url,
      :title,
      :season_year,
      :season_name_text,
      :wikipedia_url,
      :media_text
    ).where(title: cast_works_list).order(season_year: :desc)
  end
end
