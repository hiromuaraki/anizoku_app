class StaticPagesController < ApplicationController
  helper_method :status_type

  def join_anizoku
  end

  def home
    year = "今期"
    #ヘッダーへ表示する管理人のおすすめアニメ一覧を取得してくる
    work_tags_ids = Worktag.admin_recommended_list_work_id year
    works = Work.where_array(work_tags_ids)
    @works = Worktag.items_list_shuffle(works)

    #今期のアニメを取得する
    work_konki_ids = Work.content_this_term_list
    konki_shuffle_list  = Work.where_array(work_konki_ids)
    @work_contents_list = Worktag.items_list_shuffle(konki_shuffle_list)

    #前期のアニメを取得する
    work_zenki_ids = Work.content_this_term_list("前期")
    zenki_shuflle_list = Work.where_array(work_zenki_ids)
    @work_contents_zenki_list = Worktag.items_list_shuffle(zenki_shuflle_list)

    #管理人のおすすめ30選
    recomended_work_ids = Worktag.admin_recommended_list_work_id
    works_recomended = Work.where_array(recomended_work_ids)
    @works_recomended = Worktag.items_list_shuffle(works_recomended)

    #元気がない時に見たい
    feel_sad_work_ids = Worktag.get_work_tag_ids Tag.tag_id[:feel_sad]
    works_feel_sad = Work.where_array(feel_sad_work_ids)
    @works_feel_sad = Worktag.items_list_shuffle(works_feel_sad)

    #現実逃避したい時に見たい
    real_escape_ids = Worktag.get_work_tag_ids Tag.tag_id[:real_esape]
    works_real_escape = Work.where_array(real_escape_ids)
    @works_real_escape = Worktag.items_list_shuffle(works_real_escape)

    #みんなのおすすめ
    every_recomended_ids = Worktag.get_work_tag_ids Tag.tag_id[:everyone_recommended]
    every_recomended = Work.where_array(every_recomended_ids)
    @every_recomended = Worktag.items_list_shuffle(every_recomended)
    
    #異世界転生
    another_world_ids = Worktag.get_work_tag_ids Tag.tag_id[:another_world_tensei]
    another_world_tensei = Work.where_array(another_world_ids)
    @another_world_tensei = Worktag.items_list_shuffle(another_world_tensei)

    #なろう
    narou_ids = Worktag.get_work_tag_ids Tag.tag_id[:narou]
    narous  = Work.where_array(narou_ids)
    @narous =Worktag.items_list_shuffle(narous)

    #9件タグを表示する
    @tags = Tag.tag_list

    #タグの件数を取得する
    tag_ids = Tag.eager_load(:worktags).ids
    @tag_group_count = home_group_by_tag_ids(tag_ids)

    @watches_konki =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_konki_ids) : ""
    @watches_zenki =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: work_zenki_ids) : ""
    @watches_recomended =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: recomended_work_ids) : ""
    @watches_feel_sad =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: feel_sad_work_ids) : ""
    @watches_real_escape =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: real_escape_ids) : ""
    @watches_everyone_recomended =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: every_recomended_ids) : ""
    @watches_another_world =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: another_world_ids) : ""
    @watches_narous =  Watch.exists?(user_id: current_user.id) ? Watch.where(user_id: current_user.id, work_id: narou_ids) : ""
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

  #視聴ステータスを返す
  def status_type(watches, work_id)
    Watch.type_status_equal(watches, work_id)
  end

end