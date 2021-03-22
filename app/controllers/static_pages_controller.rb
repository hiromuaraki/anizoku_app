class StaticPagesController < ApplicationController

  def join_anizoku
  end

  def home
    year = "今期"
    #ヘッダーへ表示する管理人のおすすめアニメ一覧を取得してくる
    work_tags_ids = Worktag.admin_recommended_list_work_id year
    works = Work.where_array(work_tags_ids)
    @works = Worktag.items_list_shuffle(works)

    #コンテンツのアニメ一覧を取得してくる
    work_ids = Work.content_this_term_list
    @work_contents_list = Work.where_array(work_ids)
    
    #管理人のおすすめ30選
    recomended_work_ids = Worktag.admin_recommended_list_work_id
    @works_recomended = Work.where_array(recomended_work_ids)

    #元気がない時に見たい
    feel_sad_work_ids = Worktag.get_work_tag_ids Tag.tag_id[:feel_sad]
    @works_feel_sad = Work.where_array(feel_sad_work_ids)

    #現実逃避したい時に見たい
    real_escape_ids = Worktag.get_work_tag_ids Tag.tag_id[:real_esape]
    @works_real_escape = Work.where_array(real_escape_ids)

    #9件タグを表示する
    @tags = Tag.tag_list

    #タグの件数を取得する
    tag_ids = Tag.eager_load(:worktags).ids
    @tag_group_count = home_group_by_tag_ids(tag_ids)
  end

  #画面で機能制限するためのんモードを保存する
  def display_mode
    @display_mode = params[:display_mode]
    respond_to do |format|
      format.html
      format.js
    end
  end

  #グループ化したタグ一覧を返す
  def home_group_by_tag_ids(tag_ids)
    Tag.group_by_tag_ids(tag_ids)
  end

end