class MylistsController < ApplicationController
  helper_method :status_type

  def index
    mylists_ids = Mylist.where(user_id: current_user.id).pluck(:work_id)
    @works = Work.works_select(mylists_ids)
    @watches =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: mylists_ids) : ""
    season = Work.work_id_group_by_season_year_list(mylists_ids).pluck(:season_year)
    @season_list = season.group_by(&:itself)

    respond_to do |format|
      format.js
    end
  end

  #マイリストへ追加する
  def update
    @work = params[:work_id]
    if Mylist.exists?(user_id: current_user.id, work_id: params[:work_id])
      destroy
    else
      @user_mylist = Mylist.create!(
        work_id: params[:work_id],
        user_id: current_user.id,
        status: Mylist::MY_LIST_STATUS[:add]
      )
    end
    respond_to do |format|
      format.js
    end
  end

  def update2
    @work = params[:work_id]
    @url = request.headers[:REQUEST_URI]
    if Mylist.exists?(user_id: current_user.id, work_id: params[:work_id])
      destroy
    else
      @user_mylist = Mylist.create!(
        work_id: params[:work_id],
        user_id: current_user.id,
        status: Mylist::MY_LIST_STATUS[:add]
      )
    end
    respond_to do |format|
      format.js
    end
  end

  #マイリストを解除する
  def destroy
    @user_mylist = Mylist.find_by(user_id: current_user.id, work_id: params[:work_id])
    @user_mylist.destroy!
  end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

end
