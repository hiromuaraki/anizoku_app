class StaticPagesController < ApplicationController
  
  def join_anizoku
  end

  def home
    #ヘッダーへ表示する管理人のおすすめアニメ一覧を取得してくる
    work_tags_ids = Worktag.admin_recommended_list_work_id
    works  = Work.where_array(work_tags_ids)
    @works = Worktag.items_list_shuffle(works)
  end

  def privacy
  end
end
