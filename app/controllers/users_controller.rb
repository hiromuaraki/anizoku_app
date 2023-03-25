class UsersController < ApplicationController
  helper_method :status_type, :season_type, :review_default_count, :review_total_count, :watches_total_count, :mylists_total_count, :konki_total_count, :zenki_total_count, :raiki_total_count, :watch_count

  def my_page
    @mode = 0
    work_ids = params[:status].blank? ?
      Watch.where(user_id: current_user.id, status: Watch::STATUS[:watched]).pluck(:work_id) : Watch.where(user_id: current_user.id, status: params[:status].to_i).pluck(:work_id)
    
    @watches =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_ids) : ""
    
    #予め表示する件数を取得
    @watching = Watch.where(user_id: current_user.id, status: Watch::STATUS[:watching]).pluck(:work_id)
    @not_watched = Watch.where(user_id: current_user.id, status: Watch::STATUS[:not_watched]).pluck(:work_id)
    @want_watch = Watch.where(user_id: current_user.id, status: Watch::STATUS[:want_watch]).pluck(:work_id)
    
    season = Work.work_id_group_by_season_year_list(work_ids).pluck(:season_year)
    @season_list = season.group_by(&:itself)
    @works = Work.works_select(work_ids)
    @mode = Watch.status_mode(params[:status].to_i)
    # season_type = Work.work_id_group_by_season_year_list(work_ids).pluck(:season_name_text)
    # @season_list_type = season_type.group_by(&:itself)

    #ajaxへ結果を返す
    case params[:status].to_i
      when 0..3 then
        respond_to do |format|
          format.js
          format.html
        end
    end

  end
  
  def new
    @user = User.new
  end

  # def create
  #   #すでに入部済みかどうかの確認
  #   @user = User.new(user_params)
  #   #エラーが発生した場合
  #   render "new" and return if @user.invalid?
  #   if !User.find_by(email: params[:email]&.downcase)
  #     @user.build_user_profile
  #     if @user.save
  #       logged_in @user
  #       redirect_to static_pages_home_path, notice: "ようこそ、あに族へ！！"
  #     else
  #       render :new, alert: "登録に失敗しました" and return
  #     end
  #   end
  # end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

  #初期に表示させるレビュー件数
  def review_default_count(index)
    review_count = 0
    case index
      when 0 then review_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:very_good]).pluck(:work_id).size
      when 1 then review_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:good]).pluck(:work_id).size
      when 2 then review_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:normal]).pluck(:work_id).size
      when 3 then review_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:bad]).pluck(:work_id).size
    end

    return review_count
  end

  def review_total_count
    return Review.where(user_id: current_user.id).size
  end

  def watches_total_count
    return Watch.where(user_id: current_user.id).size
  end

  def mylists_total_count
    return Mylist.where(user_id: current_user.id).size
  end

  def konki_total_count
    return Work.content_this_term_list.size
  end

  def zenki_total_count
    return Work.content_this_term_list("前期").size
  end

  def raiki_total_count
    return Work.content_next_term_list.size
  end

  def watch_count(mode=nil)
    if mode.nil?
      work_ids = Work.content_this_term_list
      return watch_list = Watch.where(status: Watch::STATUS[:watching], user_id: current_user.id, work_id: work_ids).size
    else
      work_ids = Work.content_this_term_list("前期")
      return watch_list = Watch.where(status: Watch::STATUS[:watched], user_id: current_user.id, work_id: work_ids).size
    end
    
  end

  def season_type(type)
    sort_id = 0
    case type
      when "秋" then sort_id = 4
      when "夏" then sort_id = 3
      when "春" then sort_id = 2 
      when "冬" then sort_id = 1
    end
    return sort_id
  end

  #今期のアニメ一覧取得
  def get_this_term_list
    work_konki_ids = Work.content_this_term_list
    @this_term_list = Work.works_select(work_konki_ids)
    @watches_konki_list =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_konki_ids) : ""
    respond_to do |format|
      format.js
    end
  end

  #前期のアニメ一覧取得
  def get_first_term_list 
    work_zenki_ids = Work.content_this_term_list("前期")
    @first_term_list = Work.works_select(work_zenki_ids)
    @watches_zenki_list =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_zenki_ids) : ""
    respond_to do |format|
      format.js
    end
  end

  #来期のアニメ一覧取得
  def get_next_term_list
    work_raiki_ids = Work.content_next_term_list
    @next_term_list = Work.works_select(work_raiki_ids)
    @watches_raiki_list =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_raiki_ids) : ""
  end

end
