class Admin::PostsController < AdminController

  def menu
  end

  def index
    @works   = Work.includes(:worktags).page(params[:page]).order(season_year: :desc, season_id: :asc)
    tag_ids @works, "index"
  end

  def show
    @work = Work.find(params[:id])
    tag_ids @work, "show"
    @tags = Tag.all
  end

  def new
  end

  #アニメに紐付いているtag_idを一括更新する
  def update
    params[:tag_ids].each do |tag_ids|
      next if tag_ids.include?("tag")
      # Worktag.where(work_id: params[:id]).update_all(tag_id: params[:tag_ids])
    end
  end

  private

  #tag_ids一覧をwork_idごとに取得してくる
  def tag_ids(works,method_name)
    @tag_ids = []
    if method_name == "index"
      works.each do |work|
        @tag_ids << Worktag.tag_ids(work.id)
      end
    else
        @tag_ids = Worktag.tag_ids(works.id)
    end
  end

end