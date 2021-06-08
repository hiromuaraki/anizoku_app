class WatchesController < ApplicationController
  
  def index
  end

  #資料ステータスを更新する
  def update
    return if params[:watch_status].blank? || params[:work_id].blank?
    status = 0
    @watch_status = Watch.none
    if params[:watch_status] == "watched"
      status = Watch::STATUS[:watched]
    elsif params[:watch_status] == "watching"
      status = Watch::STATUS[:watching] 
    elsif params[:watch_status] == "not_watched"
      status = Watch::STATUS[:not_watched]
    else
      status = Watch::STATUS[:want_watch]
    end
    
    #すでに存在するかどうか
    if Watch.exists?(user_id: current_user.id, work_id: params[:work_id].to_i)
      @watch_status = Watch.find_by(user_id: current_user.id, work_id: params[:work_id].to_i)
      @watch_status.update!(status: status)
    else
      @watch_stats = Watch.create!(
        work_id: params[:work_id].to_i,
        user_id: current_user.id,
        status:  status
      )
    end
  end

end
