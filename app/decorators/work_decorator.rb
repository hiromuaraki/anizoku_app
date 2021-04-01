# frozen_string_literal: true
require 'net/http'
#worksテーブルのviewでの表示を加工して返す
module WorkDecorator

  #アニメ画像のステータスコードを返す
  def url_exist?(image_url)
    http = ["http", "https"]
    begin
      uri = URI.parse(image_url)
      #iamge画像にプロトコルが含まれているか
      request_url = http.any? {|h| uri.path.split("/").include?(h)}
      response = Net::HTTP.get_response(uri) if request_url
      response&.code ||= "500"
    rescue TypeError, SocketError, URI::InvalidURIError
      false
    end
  end

  #サムネイルの使うURLを判定する
  def thumbnail_url?(work)
    #データがブランクでないならimage_thumbnail ブランクなら facebook_og_image_urlを使用する
    work.image_thumbnail || work.facebook_og_image_url
  end

  #文字列を大文字へ変換する
  def str_upcase(data)
    data.upcase
  end

  #IDがすでに取得済みかどうか判定する
  def work_id_exist?(work_id)
    Work.exists?(work_id)
  end

end
