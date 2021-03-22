class TagsController < ApplicationController
  def index
    @tags = Tag.tag_all
    tag_ids = Tag.includes(:worktags).ids
    @tag_group_count = Tag.group_by_tag_ids tag_ids
  end
end
