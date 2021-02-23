class CreateWorktags < ActiveRecord::Migration[6.0]
  def change
    create_table :worktags do |t|
      t.references :work, null: false, foreign_key: true, unique: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    #同じアニメが同じタグを持つことを防ぐ
    add_index :worktags,[:work_id,:tag_id],unique: true
  end
end
