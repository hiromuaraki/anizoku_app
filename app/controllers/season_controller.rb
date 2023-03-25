class SeasonController < ApplicationController
  helper_method :status_type
  def season_list
    return if params[:year].blank?
    @year = params[:year]
    season_list = Work.where(season_year: @year).ids
    @season_list_works = season_list.group_by(&:itself)
    @works = Work.select(
      :id,
      :facebook_og_image_url,
      :title,
      :season_year,
      :season_name_text,
      :wikipedia_url,
      :media_text
    ).where(season_year: params[:year])
    @watches_season =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: season_list) : ""
    @season_list = year_list
    respond_to do |format|
      format.js
      format.html
    end

  end

  def year_list
    work = Work.select(:season_year).order(season_year: :desc).first
    year_list = (1980..work.season_year).to_a.reverse!
  end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

  
end
