class OrganizationsController < ApplicationController
  helper_method :status_type
  def index
    return if params[:organization_id].blank?
    q = params[:organization_id].to_i
    @organization ||= Staff.find_by(id: q)
    staff_work_ids = Staff.select(:work_id).where(name: @organization.name).group(:work_id).pluck(:work_id)
    season = Work.work_id_group_by_season_year_list(staff_work_ids).pluck(:season_year)
    @works = Work.select(
      :id,
      :title,
      :facebook_og_image_url,
      :season_year,
      :season_name_text,
      :description,
      :description_source,
      :official_site_url).where(id: staff_work_ids)
    @season_list = season.group_by(&:itself)
    @staffs = Staff.select(
      :id,
      :work_id,
      :name,
      :role_text,
      :role_other
    ).where(name: @organization.name)
    @watches =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: staff_work_ids) : ""
    @url = request.headers[:REQUEST_URI]
  end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end
end
