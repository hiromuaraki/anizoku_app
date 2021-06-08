# frozen_string_literal: true

module ReviewDecorator

  #現在のログイン中のユーザーの評価項目の結果を返す
  def review_items(work_id)
    review = rate_key(work_id)
    review_conversion(review)
  end

  def rate_key(work_id)
    Review.where(user_id: current_user.id, work_id: work_id).pluck(
      :rating_drawing,
      :rating_story,
      :rating_actor,
      :rating_incidental_music,
      :rating_directing,
      :rating_characters
    )
  end

  #評価項目を変換する
  def review_conversion(review_items)
    review_res = []
    review_items[0].each do |rate_key|
      case rate_key
        when 0.9 then review_res << "とても良い"
        when 0.7 then review_res << "良い"
        when 0.5 then review_res << "普通"
        when 0.2 then review_res << "良くない"
      end
    end
    
    return review_res
  end

  def review_other_user_items(work_id, other_user_id)
    review = other_rate_key(work_id, other_user_id)
    review_conversion_other_review(review)
  end

  def other_rate_key(work_id, other_user_id)
    Review.where(user_id: other_user_id, work_id: work_id).pluck(
      :rating_drawing,
      :rating_story,
      :rating_actor,
      :rating_incidental_music,
      :rating_directing,
      :rating_characters
    )
  end

  def review_conversion_other_review(review_items)
    review_res = []
    review_items[0].each do |rate_key|
      case rate_key
        when 0.9 then review_res << "とても良い"
        when 0.7 then review_res << "良い"
        when 0.5 then review_res << "普通"
        when 0.2 then review_res << "良くない"
      end
    end
    
    return review_res
  end

  #評価項目rateを数値から文字列へ変換する
  def review_conversion_selected
    review_res = []
    review ||= Review.where(user_id: current_user.id, work_id: work_id).pluck(
      :rating_drawing,
      :rating_story,
      :rating_actor,
      :rating_incidental_music,
      :rating_directing,
      :rating_characters
    )
    review[0].each do |rate_key|
      case rate_key
        when 0.9 then review_res << "very_good"
        when 0.7 then review_res << "good"
        when 0.5 then review_res << "normal"
        when 0.2 then review_res << "bad"
      end
    end
    
    return review_res
  end

  #総合評価の結果を返す
  def review_synthsesis_rate(work_id)  
    synthsesis_rate = Review.find_by(user_id: current_user.id, work_id: work_id)
    return "とても良い" if synthsesis_rate.rate.between?(4.6, 5.4)
    return "良い" if synthsesis_rate.rate.between?(4.0, 4.5)
    return "普通" if synthsesis_rate.rate.between?(3.0, 3.9)
    return "良くない" if synthsesis_rate.rate.between?(1.0, 2.99)
    # return "人を選ぶ" if synthsesis_rate.rate.between?(0.0, 1.99)
  end
    
    #総合評価の結果を返す
  def other_review_synthsesis_rate(other_rate)  
    return "とても良い" if other_rate.between?(4.6, 5.4)
    return "良い" if other_rate.between?(4.0, 4.5)
    return "普通" if other_rate.between?(3.0, 3.9)
    return "良くない" if other_rate.between?(1.0, 2.99)
    # return "人を選ぶ" if other_rate.between?(0.0, 1.99)
  end

  #ドロップダウンリストの項目を返す
  def review_select_list
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

  #ログイン中のユーザー以外のレビューが存在するか
  def review_not_current_user_exists?(work)
    Review.where.not(user_id: current_user.id, work_id: work.id).exists?
  end

end
