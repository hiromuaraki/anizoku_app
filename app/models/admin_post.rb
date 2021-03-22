class AdminPost < ApplicationRecord
  #イメージ画像をアップロードするためのマウント
  mount_uploader :image, ImageUploader
end
