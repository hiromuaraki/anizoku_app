#初期データの準備

require "net/http"
require "uri"
require "json"
require "csv"

CSV_FILE_SF = "SF_ファンタジー.csv"
CSV_FILE_ROBOT_MEKA = "ロボット_メカ.csv"
CSV_FILE_ACTION_BATTLE = "アクション_バトル.csv"
CSV_FILE_COMEDY_GYAG = "コメディ_ギャグ.csv"
CSV_FILE_RENAI_LOVECOME = "恋愛_ラブコメ.csv"
CSV_FILE_EVERY_HONOBONO = "日常_ほのぼの.csv"
CSV_FILE_SPORTS_KYOUGI = "スポーツ_競技.csv"
CSV_FILE_HORROR_SASPENCE_MISTERY = "ホラー_サスペンス_ミステリー.csv"
CSV_FILE_HISTORY_SENKI = "歴史_戦記.csv"
CSV_FILE_WAR_MIRITARY = "戦争_ミリタリー.csv"
CSV_FILE_DORAMA_YOUTH = "ドラマ_青春.csv"
CSV_FILE_SHORT = "ショート.csv"
CSV_FILE_WOMAN_POP = "女性に人気.csv"
CSV_FILE_RANOBE = "ラノベ.csv"
CSV_FILE_NAROU = "なろう.csv"
CSV_FILE_KIRARA = "まんがタイムきらら.csv"
CSV_FILE_RORI = "幼女.csv"
CSV_FILE_GURO = "グロ.csv"
CSV_FILE_MOE = "萌え.csv"
CSV_FILE_UTSU = "鬱.csv"
CSV_FILE_YURI = "百合.csv"
CSV_FILE_BAKUSYO = "爆笑.csv"
CSV_FILE_YOUTH = "青春.csv"
CSV_FILE_WORK = "お仕事.csv"
CSV_FILE_BRAIN = "頭脳戦_心理戦.csv"
CSV_FILE_TIME_LEEP = "タイムリープ.csv"
CSV_FILE_MAIN_STRONG = "主人公最強.csv"
CSV_FILE_YANDERE = "ヤンデレ.csv"
CSV_FILE_TSUNDERE = "ツンデレ.csv"
CSV_FILE_IDOL = "アイドル.csv"
CSV_FILE_IYASI = "癒し.csv"
CSV_FILE_POPULAR = "人気.csv"
CSV_FILE_CRY = "泣ける.csv"
CSV_FILE_SCHOOL = "学園.csv"
CSV_FILE_SUMMER_VACATION = "夏休みに観たい.csv"
CSV_FILE_GAME = "ゲーム原作.csv"
CSV_FILE_ERO_GAME = "エロゲー.csv"
CSV_FILE_ADMIN_LIKE = "管理人のおすすめ.csv"
CSV_FILE_ENERGY = "元気がない時に観たい.csv"
CSV_FILE_BOYS_LOVE = "BL.csv"
CSV_FILE_SISTER = "妹.csv"
CSV_FILE_SYOTA = "ショタ.csv"
CSV_FILE_DARK_SIDE = "闇堕ち.csv"
CSV_FILE_TUTO_RIAL = "アニメ入門.csv"
CSV_FILE_DIFFERENT_RELIFE = "異世界転生.csv"
CSV_FILE_DIFFERENT_WORLD = "異世界.csv"
CSV_FILE_SUPER_MOEMOE = "超超萌え萌え.csv"


CSV_FILE_TAG = "タグデータ.csv"
# YEAR_LIST = 1900..(Time.now.year)
# YEAR = YEAR_LIST.to_a.reverse!
SEASON = {winter: "冬", spring: "春", summer: "夏", autumn: "秋"}
NEXT_PAGE_NO = 24

#mainメソッド
def common_add_model_data(name)
  response = first_requst(name)
  puts "ループ終了です。" if response_not_nil?(response, name)
end

#最初のAPIリクエスト
def first_requst(req_name)
  req_url  = get_change_req_url(req_name)
  response = request_api(req_url)
end

#API実行｜jsonデータを配列へ変換し返す
def request_api(url = "https://api.annict.com/v1/works?access_token=jxP8gQxK0VAjiYCOQaBgBA82G-N5nfTNIEAKs6fuuwM\&filter_season=1987-autumn\&page=1")
  #返ってきたjsonデータをrubyの配列に変換
  req_url = URI.parse(url)
  json = Net::HTTP.get(req_url)
  response = JSON.parse(json)
end

#ページ数を動的に変更する
def get_change_req_url(table="work", page = 1)
  req_url = "https://api.annict.com/v1/#{table}?access_token=jxP8gQxK0VAjiYCOQaBgBA82G-N5nfTNIEAKs6fuuwM&page=#{page.to_i}"
end

#次のページをリクエストする
def get_next_page(page_no, table_name)
  req_url  = get_change_req_url(table_name, page_no)
  response = request_api(req_url)
end

#例外時エラーメッセージ
def error_msg(e_msg)
  puts "エラー内容：#{e_msg}"
  puts "クラス名：#{e_msg.class}"
  puts "親クラス名：#{e_msg.class.superclass}"
  puts "元親クラス名：#{e_msg.class.superclass.superclass}"
end

#文字列が有効なJSONか確認する
def valid_json?(string)
  begin
    !!JSON.parse(string)
  rescue JSON::ParserError
    false
  end
end

#各モデルごとに最終ページまでリクエストを繰り返す
def response_not_nil?(response, req_name)
  page_no = 1
  count   = 0
  while !response["next_page"].nil?
    response[req_name].each_with_index do |data, index|
      #各モデルを追加する
      case req_name
      when "casts" then
        add_cast_data(data)
      when "characters" then
        add_character_data(data)
      when "organizations" then
        add_organization_data(data)
      when "staffs" then
        add_staffs_data(data)
      when "series" then
        add_series_data(data)
      when "works"  then
        add_work_data
      end

      if index == NEXT_PAGE_NO
        page_no += 1
        count += 1
        response = get_next_page(page_no, req_name)
        puts "デバッグ#{count}/ページNO=#{page_no}"
      end
    end
  end

  return true
end

#モデルからあいまい検索してくる
def find_by_like_from_model(model_name, fields, conditions)
  model_name.find_by("#{fields} like?", "%#{conditions}%")
end

private

#シーズンの追加
def add_season_data
  begin
    Season.find_or_create_by(name: SEASON[:autumn])
  rescue => e
    error_msg(e)
  end
end

#シリーズの追加
def add_series_data(series)
  begin
    Series.find_or_create_by(name: series["name"])
    puts "シリーズ名：#{series["name"]}"
  rescue => e
    error_msg(e)
  end
end

#キャラクターの追加
def add_character_data(character)
  begin
    work = Work.find_by(title: character["work"]["title"])
    Character.find_or_create_by(
      work_id: work&.id, 
      name: character["character"]["name"],
      nick_name: character["character"]["nickname"],
      birthday: character["character"]["birthday"],
      age: character["character"]["age"],
      blood_type: character["character"]["blood_type"],
      description: character["character"]["description"],
      description_source: character["character"]["description_source"]
    )
    puts "work_id：#{work&.id}/タイトル：#{character["work"]["title"]}"
    
  rescue => e
    error_msg(e)
  end
end

#キャストの追加
def add_cast_data(cast)
  begin
    character = Character.find_by(name: cast["character"]["name"])
    Cast.find_or_create_by(
      character_id: character.id,
      work_title: cast["work"]["title"],
      name: cast["person"]["name"],
      name_kana: cast["person"]["name_kana"],
      gender: cast["person"]["gender_text"],
      blood_type: cast["person"]["blood_type"],
      birthday: cast["person"]["birthday"],
      url: cast["person"]["url"],
      wikipedia_url: cast["person"]["wikipedia_url"] 
    )
    puts "#{character&.id}：キャスト：#{cast["person"]["name"]}：タイトル：#{cast["work"]["title"]}：キャラクター:#{cast["character"]["name"]}"
    
  rescue => e
    error_msg(e)
  end
end

#スタッフの追加
def add_staffs_data(staff)
  begin
    work = Work.find_by(title: staff["work"]["title"])
    Staff.find_or_create_by(
      work_id: work&.id,
      name: staff["name"],
      role_text: staff["role_text"],
      role_other: staff["role_other"]
    )
    puts "#{work&.id}：監督：#{staff["name"]}：スタッフ#{staff["role_text"]}| #{staff["role_other"]}：タイトル：#{staff["work"]["title"]}"

  rescue => e
    error_msg(e)
  end
end

#団体情報追加
def add_organization_data(organization)
  begin
    Organization.find_or_create_by(
      name: organization["name"],
      name_kana: organization["name_kana"],
      name_en: organization["name_en"],
      url: organization["url"],
      wikipedia_url: organization["wikipedia_url"],
      twitter_name: organization["twitter_name"]
    )
    puts "団体名:#{organization["name"]}：#{organization["name_en"]}"

  rescue => e
    error_msg(e)
  end
end

#アニメデータの追加
def add_work_data
  table_name = "works"
  response = request_api
  
  response[table_name].each do |work|
    begin
      season = Season.find_by(name: SEASON[:autumn])
      Work.find_or_create_by(
        season_id: season.id,
        season_name: work["season_name"],
        season_name_text: work["season_name_text"],
        season_year: work["season_name"],
        title: work["title"],
        episodes_count: work["episodes_count"],
        facebook_og_image_url: work["images"]["facebook"]["og_image_url"],
        released_at: work["released_at"],
        media: work["media"],
        media_text: work["media_text"],
        official_site_url: work["official_site_url"],
        twitter_hashtag: work["twitter_hashtag"],
        twitter_image_url: work["images"]["twitter"]["twitter_image_url"].nil? ? "" : work["images"]["twitter"]["twitter_image_url"],
        twitter_username: work["twitter_username"],
        recommended_image_url: work["images"]["recommended_image_url"].nil? ? "" : work["images"]["recommended_image_url"],
        wikipedia_url: work["wikipedia_url"]
        
      )
    rescue ActiveRecord::RecordNotUnique
      retry
    end

  end
end

# def get_model_find_by(model, conditions, value)
#   model_data ||= model.find_by("#{conditions}:" value)
# end

# #アニメとタグのデータを紐付ける
# def add_worktags_data
  
#   Worktag.find_or_create_by(
#     work_id: ,
#     tag_id:  ,
#   )
  

# end

# def create_csv_data
#   csv_data = CSV.generate do |csv|
#     column_names = %w(id tag_id タイトル)
#     #ヘッダーを空白ごとに設定
#     csv << column_names

#     # # column_valuesに代入するカラム値を定義します。
#     # posts.each do |post|
#     #   column_values = [
#     #     post.user.name,
#     #     post.title,
#     #     post.body,
#     #           ]
#     # # csv << column_valueshは表の行に入る値を定義します。
#     #   csv << column_values
#     # end
#   end
#   # csv出力のファイル名を定義します。
#   send_data(csv_data, filename: "投稿一覧.csv")
# end

#csvファイルからデータを取得してくる
def add_danime_data(tags = "tags")
  count = 1
  if tags == "tags"
    CSV.foreach("db/data/csv/#{CSV_FILE_TAG}", headers: true) do |row|
        Tag.find_or_create_by(name: row["title"])
      puts "デバッグ#{count}/タグ名：#{row["title"]}"
      count += 1
    end
  else
    begin
      tag = Tag.find_by(name: "超超萌え萌え")
      #先頭のヘッダーをスキップする
      CSV.foreach("db/data/csv/#{CSV_FILE_SUPER_MOEMOE}", headers: true) do |row|
        Danime.find_or_create_by(
          tag_id: tag.id,
          title:  row["title"],
        )
        puts "デバッグ#{count}：tag_id：#{tag.id}：タイトル：#{row["title"]}"
        count += 1
      end
    rescue => e
      error_msg(e)
    end
  end
end

add_danime_data("danime")
# add_danime_data

# common_add_model_data("organizations")
