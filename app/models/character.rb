class Character < ApplicationRecord
  #関連付けの確認を行わない
  belongs_to :work, optional: true

  #重複しないキャラクターデータを取得する
  scope :where_search_characters, ->(key) do
    where("name LIKE ?", "%#{key}%")
  end

end
