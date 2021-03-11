class StaticPagesController < ApplicationController  

  def join_anizoku
  end

  def home
    #ヘッダーへ表示する管理人のおすすめアニメ一覧を取得してくる
    work_tags_ids = Worktag.admin_recommended_list_work_id
    works  = Work.where_array(work_tags_ids)
    @works = Worktag.items_list_shuffle(works)

    #コンテンツのアニメ一覧を取得してくる
    work_ids = Work.content_this_term_list
    work_list = Work.where_array(work_ids).limit(12)
    @work_contents_list = Worktag.items_list_shuffle(work_list)

    #タグ一覧を取得する
    @tags = Tag.tag_list
  
  end

  #画面で機能制限するためのんモードを保存する
  def display_mode
    @display_mode = params[:display_mode]
    respond_to do |format|
      format.html
      format.js
    end
  end

end
