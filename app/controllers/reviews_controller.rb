class ReviewsController < ApplicationController
  helper_method :user_rate, :user_select_list
  #レビューのタブの表示させるデータ
  def reviews
    return if !Review.exists?(user_id: current_user.id)

    @review_very_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:very_good]).pluck(:work_id).size
    @review_good_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:good]).pluck(:work_id).size
    @review_normal_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:normal]).pluck(:work_id).size
    @review_bad_count = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:bad]).pluck(:work_id).size
    @review_mode = 0

    case params[:rate].to_i
      when 0 then
        review_ids = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:very_good]).pluck(:work_id)
        @review_mode = 0
      when 1 then
        review_ids = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:good]).pluck(:work_id)
        @review_mode = 1
      when 2 then
        review_ids = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:normal]).pluck(:work_id)
        @review_mode = 2
      when 3 then
        review_ids = Review.where(user_id: current_user.id, rate: Review::RATE_SCORE[:bad]).pluck(:work_id)
        @review_mode = 3
    end

    review_season = Work.work_id_group_by_season_year_list(review_ids).pluck(:season_year)
    @review_season_list = review_season.group_by(&:itself)

    @review_works = Work.works_select(review_ids)
    
    respond_to do |format|
      format.js
    end
    
  end

  def index
  end

  def update
    @review ||= Review.find_by(user_id: current_user.id, work_id: params[:work_id].to_i)
    rate_list = Review.rate_conversion(review_params)
    
    #評価項目を更新する
    @review.update!(
      user_id: current_user.id,
      work_id: params[:work_id].to_i,
      rate: rate_list["sum"],
      rating_drawing: rate_list["rating_drawing"],
      rating_story: rate_list["rating_story"],
      rating_actor: rate_list["rating_actor"],
      rating_incidental_music: rate_list["rating_incidental_music"],
      rating_directing: rate_list["rating_directing"],
      rating_characters: rate_list["rating_characters"],
      content: params[:content]
    )
    
    #更新がされたかどうか
    flash[:notice] = "更新されました〜！！"
    redirect_to "/works/detail/#{params[:work_id]}"
  end

  def user_rate(work_id)
    Review.rate_key_lsit(work_id, current_user.id)
  end

  def user_select_list
    Review.user_review_select_list
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
