class AddTagCheckedToWorktags < ActiveRecord::Migration[6.0]
  def change
    add_column :worktags, :tag_checked, :boolean, after: :tag_id, default: false
  end
end
