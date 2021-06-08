class TagsController < ApplicationController
  helper_method :status_type

  def index
    @tags = Tag.tag_all
    tag_ids = Tag.includes(:worktags).ids
    @tag_group_count = Tag.group_by_tag_ids tag_ids
  end

  #タグを持っている一覧を取得する
  def work_tag_list
    @tag = Tag.find_by(id: params[:tag_id])
    tag_ids = Tag.eager_load(:worktags).ids
    @tags = Tag.where(id: tag_ids).first(9)
    work_tag_ids = Worktag.where(tag_id: params[:tag_id]).pluck(:work_id)
    staff_work_ids = Staff.select(:work_id).where(name: @tag.name).group(:work_id).pluck(:work_id)
    # @first_group_count = Tag.group_by_tag_ids tag_ids
    season_staff = Work.work_id_group_by_season_year_list(staff_work_ids).pluck(:season_year)
    season_works = Work.work_id_group_by_season_year_list(work_tag_ids).pluck(:season_year)

    @staff_works = Work.select(
      :id,
      :title,
      :facebook_og_image_url,
      :season_year,
      :season_name_text,
      :description,
      :description_source,
      :official_site_url).where(id: staff_work_ids)

    @works = Work.select(
      :id,
      :title,
      :facebook_og_image_url,
      :season_year,
      :season_name_text,
      :description,
      :description_source,
      :official_site_url).where(id: work_tag_ids)
    
    @season_list_staff = season_staff.group_by(&:itself)
    @season_list_works = season_works.group_by(&:itself)
    @watches_staff =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: staff_work_ids) : ""
    @watches_works =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_tag_ids) : ""
    
    respond_to do |format|
      format.js
      format.html {render "_work-tag-list" }
    end
  end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

end
