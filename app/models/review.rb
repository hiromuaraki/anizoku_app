class Review < ApplicationRecord  
  belongs_to :work
  belongs_to :user
  
  #評価項目（5段階評価)
  #とても良い:very_good 良い:good 普通:normal 良くない:bad
  RATE = {
    "very_good": 0.9,
    "good": 0.7,
    "normal": 0.5,
    "bad": 0.2
  }

  RATE_SCORE = {
    "very_good": 4.5...5.4,
    "good": 3.8...4.5,
    "normal": 3.0...3.8,
    "bad": 1.0...2.99
  }
  
  with_options exclusion: { in: %w(very_good good normal bad) } do
    validates :rating_drawing
    validates :rating_story
    validates :rating_actor
    validates :rating_incidental_music
    validates :rating_directing
    validates :rating_characters
  end
  
  #レビューの評価項目の検証
  with_options presence: {message: "が選択されていません。" } do
    validates :rating_drawing
    validates :rating_story
    validates :rating_actor
    validates :rating_incidental_music
    validates :rating_directing
    validates :rating_characters
  end

  with_options length: { maximum: 280 } do
    validates :content
  end

  #レビュー時の評価項目をk,vで変換する
  def self.rate_conversion(review_params_list)
    rate_sum = 0.0
    rate_list = Hash.new
    review_params_list.each do |k, v|
      next if v.blank?
      rate_sum += RATE[:"#{v}"]
      rate_list[k] = RATE[:"#{v}"]
    end
    rate_list["sum"] = rate_sum
    return rate_list
  end

  def self.rate_key_lsit(work_id, user_id)
    review_items = Review.where(user_id: user_id, work_id: work_id).pluck(
      :rating_drawing,
      :rating_story,
      :rating_actor,
      :rating_incidental_music,
      :rating_directing,
      :rating_characters
    )

    return rate_list(review_items)
  end

  def self.rate_list(review_items)
    review_res = []
    # binding.pry
      review_items[0].each_with_index do |rate_key, count|
        case rate_key
          when 0.9 then review_res << "とても良い"
          when 0.7 then review_res << "良い"
          when 0.5 then review_res << "普通"
          when 0.2 then review_res << "良くない"
        end
      end
    
    return review_res
  end

  #ドロップダウンリストの項目を返す
  def self.user_review_select_list
    drop_down_list = [
      "作画/世界観",
      "脚本(STORY)",
      "演技",
      "劇伴/音響",
      "演出",
      "キャラクター"
    ]
    return drop_down_list
  end

  #初めてのレビューの時だけ表示する
  def self.first_review(user_id)
    Review.exists?(user_id: user_id)
  end

  #ログイン中のユーザーのレビューがすでにあるか
  def self.already_review_exists?(current_user_id, work_id)
    Review.exists?(user_id: current_user_id, work_id: work_id)
  end

  #他のユーザーのレビューが存在するかどうか
  def self.review_not_current_user(user_id, work_id)
    Review.where.not(user_id: user_id).where(work_id: work_id)
  end

end