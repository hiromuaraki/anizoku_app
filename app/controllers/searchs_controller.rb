class SearchsController < ApplicationController
  #入力されたタイトルから作品名/キャラクター名/声優名を検索する
  def item_search
    @works ,@casts, @characters = Work.none, Cast.none, Character.none
    redirect_to static_pages_home_path and return if params[:q][:title_cont]&.blank?
    @cast_count = 0
    #入力値から合致するデータを先に検索する
    works = Work.where("title LIKE ?", "%#{params[:q][:title_cont]}%").order(season_year: :desc)
    
    if works.blank?
      keywords = Work.keywords_split(params[:q][:title_cont]).uniq
      if keywords.size > 1
        keywords.each_with_index do |key, i|
          @works += Work.where("title LIKE ?", "%#{key}%").order(season_year: :desc)
          #キャラクター名を取得
          if !@works[i].blank?
            @works[i].characters.each do |character|
              @characters += Work.keywords_split(character.name)
            end
            #声優名を取得
            @works[i].casts.each do |cast|
              @casts += Work.keywords_split(cast.name)
              @cast_count += Work.keywords_split(cast.name).size
            end

          end
        end
      end

    else
      #先に完全一致検索を行い、検索結果がなかったら曖昧検索をする
      @works = works
      character_list = []
      @works.size.times do |i|
        @works[i].characters.each do |character|
          next if character_list.include?(character&.name)
          @characters += Work.keywords_split(character.name)
          @cast_count += Work.keywords_split(character.name).size
          character_list << character&.name
        end
      end
      
    end
  end

end
