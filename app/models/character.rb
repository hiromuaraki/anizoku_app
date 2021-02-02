class Character < ApplicationRecord
  #関連付けの確認を行わない
  belongs_to :work, optional: true
end
