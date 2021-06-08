class WorksController < ApplicationController
  helper_method :first_review?

  def index
    @work ||= Work.select(
      :id,
      :title,
      :facebook_og_image_url,
      :season_year,
      :season_name_text,
      :description,
      :description_source,
      :official_site_url
    ).find_by(id: params[:work_id])
    @work.title = @work.title.gsub("劇場版", "").strip
    @staffs = Staff.where(work_id: params[:work_id])
    tag_ids = Worktag.where(work_id: params[:work_id]).pluck(:tag_id)
    @tags = Tag.where(id: tag_ids)
    @review = Review.find_by(user_id: current_user.id, work_id: params[:work_id])
    @other_reviews = Review.review_not_current_user(current_user.id, params[:work_id]).order(created_at: :desc)
    @series = Work.where("title LIKE ?", "%#{@work.title.slice(0, 5)}%").size == 1 ?  "" : Work.where("title LIKE ?", "#{@work.title.slice(0, 5)}%").order(season_year: :asc)
    # series_ids = WorkSeries.where(work_id: @work.id).pluck(:series_id)
    # @series = WorkSeries.where(series_id: series_ids).size == 1 ? "" : WorkSeries.where(series_id: series_ids)
    @watch =  Watch.exists?(user_id: current_user.id, work_id: params[:work_id]) ? Watch.find_by(user_id: current_user.id, work_id: params[:work_id]) : ""
    @url = request.headers[:REQUEST_URI]
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    #現在ログインしているユーザーと作品を紐付ける
    @review.user_id = current_user.id
    @review.work_id = params[:work_id].to_i
    
    if @review.valid?
      rate_list = Review.rate_conversion(review_params)
    else
      render "create.js.erb" and return
    end

    #評価項目のセット
    @review.rating_drawing = rate_list["rating_drawing"]
    @review.rating_story = rate_list["rating_story"]
    @review.rating_actor = rate_list["rating_actor"]
    @review.rating_incidental_music = rate_list["rating_incidental_music"]
    @review.rating_directing = rate_list["rating_directing"]
    @review.rating_characters = rate_list["rating_characters"]
    @review.rate = rate_list["sum"]
    @review.content = params[:content] if !params[:content].nil?
    
    flash[:notice] = first_review? ? "レビューを投稿しました〜！！" : "初めてのレビュー投稿おめでとうございます〜👏👏" 
    #レビューが初めてかどうか
    unless @review.save!
      redner :index, alert: "【失敗】保存ができませんでした。" and return
    else
      return redirect_to params[:url]
    end

  end

  def update
  end

  def first_review?
    Review.first_review(current_user.id)
  end

  private

  def review_params
    params.permit(
      :rating_drawing,
      :rating_story,
      :rating_actor,
      :rating_incidental_music,
      :rating_directing,
      :rating_characters
    )
  end
end
