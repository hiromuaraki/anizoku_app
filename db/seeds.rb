#初期データの準備

require "net/http"
require "uri"
require "json"
require "csv"

CSV_FILE_TAG = "タグデータ.csv"
CSV_FILE_NULL_LIST = "worksにないデータ一覧.csv"
CSV_FILE_NOT_NULL_LIST = "worksにあるデータ一覧.csv"
CSV_FILE_WORKS_LIST = "追加するリスト.csv"
CSV_FILE_WORKS_CAST_LIST = "追加データ一覧.csv"
CSV_FILE_WORK_TAG_LIST = "worktagリスト.csv"

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
CSV_FILE_EVERY_ONE_RECOMEND = "みんなのおすすめ.csv"
CSV_FILE_HAREM = "ハーレム.csv"

# YEAR_LIST = 1900..(Time.now.year)
# YEAR = YEAR_LIST.to_a.reverse!
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
def request_api(url = "https://api.annict.com/v1/works?access_token=jxP8gQxK0VAjiYCOQaBgBA82G-N5nfTNIEAKs6fuuwM\&filter_season=1980-autumn\&page=1")
  req_url = URI.parse(url)
  json = Net::HTTP.get(req_url)
  response = JSON.parse(json)
end

#ページ数を動的に変更する
def get_change_req_url(table="works", page = 1)
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
  model_name.find_by("#{fields} like ?", "%#{conditions.slice(0..3)}%")
end

#先頭から4文字抽出した検索結果を配列で取得
def where_like_from_model(model_name, fields, conditions)
  model_name.where("#{fields} like ?", "%#{conditions.slice(0..4)}%")
end

#csvファイルへ書き出す（追記モード）
def common_write_csv_file_model_data(parent_model, child_model, csv_file_path, mode="worktag")
  parent_data = parent_model.all
  csv_data = CSV.open("db/data/csv/#{csv_file_path}", "w") do |csv|
    column_names = %w(work_id work_title danime_title tag_id tag_name) if mode =="worktag"
    column_names = %w(work_id cast_id work_title cast_title cast_name) if mode =="workcast"
    column_names = %w(id  title) if mode.nil?
    #最初の1行目にカラム設定
    csv << column_names
    
    # column_valuesに代入するカラム値を定義します。
    parent_data.each do |parent|
      child_data = child_model.where(title: parent.title)
      child_data.each do |child|
        tag = Tag.find_by(id: child.tag_id)
        if !child.nil?
          column_values = [
            parent.id,
            parent.title,
            child.title,
            child.tag_id,
            tag.name,
          ]
          # csv << column_valueshは表の行に入る値を定義します。
          csv << column_values
        end
      end
    end
  end
  puts "ループ終了です〜"
end

#データ一覧をcsvファイルへ出力する
def create_csv_data(columns = nil)
  works = Work.all
  csv_data = CSV.open("db/data/csv/#{CSV_FILE_WORKS_LIST}", "w") do |csv|
    column_names = %w(work_id tag_id danime_title work_title)
    column_names = %w(id  title) if columns.nil?
    #最初の1行目にカラム設定
    csv << column_names
    
    # column_valuesに代入するカラム値を定義します。
    works.each do |work|
      danimes = where_like_from_model(Danime, "title", work.title)
      danimes.each do |danime|
        column_values = [
          work.id,
          danime&.tag_id,
          danime&.title,
          work.title,
        ]
        # csv << column_valueshは表の行に入る値を定義します。
        csv << column_values
        
      end
    end
  end
end

private

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
      Work.find_or_create_by(
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

#アニメと声優のデータを紐付ける
def add_workcasts_data(work, cast, count)
  if !cast.nil?
    Workcast.find_or_create_by(
      work_id: work.id,
      cast_id: cast.id
    )
  end
  puts "デバッグ#{count}/id:#{work.id}:#{cast.id}:title:#{work.title}:work_title:#{cast.work_title}:CV#{cast.name}"
  count += 1
end

#アニメとタグのデータを紐付ける
def add_worktags_data(work, danime, tag_ids)
  tag_ids << danime.tag_id
  Worktag.create!(
    work_id: work.id,
    tag_id:  danime.tag_id,
    tag_checked: false
  )
  puts "work_id :#{work.id} :work_title :#{work.title} :danime_title :#{danime.title} :tag_ids :#{tag_ids}"
end

#workテーブルと各関連モデルを紐付け、データを追加する
def add_work_relation_model(parent_model, child_model, fields, model_name)
  parent_model.all.each do |parent|
    tag_ids = []
    child_model.where(title: parent.title).each do |child|
      
      case model_name.name
      when "Worktag" then
        add_worktags_data(parent, child, tag_ids)
      when "Workcast" then
        add_workcasts_data(parent, child)
      end
    end
  end
end


def open_csv_model_create(tags = "tags")
  count = 1
  #タグデータ新規追加
  if tags == "tags"
    CSV.foreach("db/data/csv/#{CSV_FILE_TAG}", headers: true) do |row|
      #すでに存在する場合は作成しない
      Tag.find_or_create_by(name: row["title"])
      puts "デバッグ#{count}/タグ名：#{row["title"]}"
      count += 1
    end
  else
    begin
      tag = Tag.find_by(name: "")
      #先頭のヘッダーをスキップする
      CSV.foreach("db/data/csv/#{}", headers: true) do |row|
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

# add_work_data
# common_add_model_data("")
# open_csv_model_create("danime")
# open_csv_model_create
# add_work_relation_model(Work, Cast, "work_title", Workcast)
# add_work_relation_model(Work, Danime, "title", Worktag)
# common_write_csv_file_model_data(Work, Cast, CSV_FILE_WORKS_CAST_LIST, "NOT_NULL")
# common_write_csv_file_model_data(Work, Danime, CSV_FILE_WORK_TAG_LIST, "worktag")