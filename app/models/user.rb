class User < ApplicationRecord
  attr_accessor :remember_token

  #レビュー情報を紐づける
  has_many :reviews, dependent: :destroy
  has_many :works, through: :reviews

  #視聴ステータスを紐付ける
  has_many :watches, dependent: :destroy
  has_many :works, through: :watches

  #マイリストを紐付ける
  has_many :mylists, dependent: :destroy
  has_many :works, through: :mylists
  
  has_one :user_profile, dependent: :destroy
  
  #渡された文字列のハッシュ値を返す
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #ランダムなトークンを返すs
  def new_token
    SecureRandom.urlsafe_base64
  end

  #永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
