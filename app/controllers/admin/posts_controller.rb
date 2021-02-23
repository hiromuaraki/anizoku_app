
class Admin::PostsController < AdminController

  def menu
  end

  def index
    @works   = Work.includes(:worktags).page(params[:page]).order(id: :asc, season_year: :desc)
    tag_ids @works, "index"
  end

  def show
    @url = request.headers[:referer]
    @work = Work.find(params[:id])
    tag_ids @work, "show"
    @tags = Tag.all
  end

  def new
  end

  def create
    params[:tag_ids][:tag].each do |tag_id|
      Worktag.create!(
        work_id: params[:format],
        tag_id: tag_id,
        tag_checked: true
      )
    end
    redirect_to params[:url]
  end

  def update
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