# frozen_string_literal: true
require 'net/http'

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

end
