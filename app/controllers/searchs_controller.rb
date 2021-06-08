class SearchsController < ApplicationController
  helper_method :status_type
  #入力されたタイトルから作品名/キャラクター名/声優名を検索する
  def item_search
    redirect_to static_pages_home_path and return if params[:q_search]&.blank?
    @characters = Character.none
    @cast_count = 0

    @works = Work.where("title LIKE ?", "%#{params[:q_search]}%").order(season_year: :desc)
    work_ids = @works.ids
    @cast_name = Cast.where("name LIKE ?", "%#{params[:q_search]}%").pluck(:name).uniq!
    @cast_name_kana = Cast.where("name LIKE ?", "%#{params[:q_search]}%").pluck(:name_kana).uniq!
    @name_count = @cast_name.size if !@cast_name.nil?
    @cast_name = "" if @cast_name.nil?
    @cast_name_kana = "" if @cast_name_kana.nil?
    @watches =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_ids) : ""
    
    #先に完全一致検索を行い、検索結果がなかったら曖昧検索をする
    character_list = []
    if !@works.blank?
      @works.size.times do |i|
        @works[i].characters.each do |character|
          next if character_list.include?(character&.name)
          @characters += Work.keywords_split(character.name)
          @cast_count += Work.keywords_split(character.name).size
          character_list << character.name
        end
      end
    end
  end

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

end
