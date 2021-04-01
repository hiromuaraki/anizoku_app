#初期データの準備

require "net/http"
require "uri"
require "json"
require "csv"
require 'open-uri'

#検証用
CSV_FILE_TAG = "タグデータ.csv"
CSV_FILE_NULL_LIST = "worksにないデータ一覧.csv"
CSV_FILE_NOT_NULL_LIST = "worksにあるデータ一覧.csv"
CSV_FILE_WORKS_LIST = "追加するリスト.csv"
CSV_FILE_WORKS_CAST_LIST = "追加データ一覧.csv"
CSV_FILE_WORK_TAG_LIST = "worktagリスト.csv"
CSV_FILE_WORK_TAG_LIST_DESTROY_BEFORE_LIST = "worktag削除前リスト.csv"
CSV_FILE_WORK_SERIES_LIST = "workの検索結果がnilのデータ.csv"
CSV_FILE_CHARACTER_LIST = "workの検索結果がnilのデータ_キャラクター.csv"
CSV_FILE_CAST_LIST = "characterの検索結果がnilのデータ_キャスト.csv"
CSV_FILE_URL_IMAGE_LIST = "danime_imagesのURLデータ一覧とworksの比較.csv"

# イメージ管理
CSV_FILE_IMAGE_URL_SF = "images_url_sf.csv"
CSV_FILE_IMAGE_URL_ROBO_MEKA = "images_url_robo_meka.csv"
CSV_FILE_IMAGE_URL_ACTION_BATTLE = "images_url_action_battle.csv"
CSV_FILE_IMAGE_URL_COMEDY_GYG = "images_url_comedy_gyg.csv"
CSV_FILE_IMAGE_URL_LOVEKOME = "images_url_lovekome.csv"
CSV_FILE_IMAGE_URL_HONOBONO = "images_url_honobono.csv"
CSV_FILE_IMAGE_URL_SPORTS = "images_url_sports.csv"
CSV_FILE_IMAGE_URL_HORA_MISTERY = "images_url_horr_mistery.csv"
CSV_FILE_IMAGE_URL_HISTORY_SENKI = "images_url_history_senki.csv"
CSV_FILE_IMAGE_URL_WAR_MIRITARY = "images_url_war_miritary.csv"
CSV_FILE_IMAGE_URL_DORAMA_YOUTH = "images_url_dorama_youth.csv"
CSV_FILE_IMAGE_URL_SHORT = "images_url_short.csv"
CSV_FILE_IMAGE_URL_25BUTAI = "images_url_2.5butai.csv"

#各VOD
CSV_FILE_IMAGE_URL_ABEMA = "abema_image_url.csv"
CSV_FILE_IMAGE_URL_AMAZON_PRIME = "amazon_prime_list.csv"

# タグのデータ管理（随時追加予定）
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

#APIの１Pの最大ページ数
NEXT_PAGE_NO = 24

#mainメソッド
def common_add_model_data(name:)
  response = first_requst(name)
  puts "ループ終了です。" if response_not_nil?(response, name)
end

#最初のAPIリクエスト
def first_requst(req_name)
  req_url  = get_change_req_url(table: req_name)
  response = request_api(req_url)
end

#ページ数を動的に変更する
def get_change_req_url(table: "works", page_no: 1)
  req_url = "https://api.annict.com/v1/#{table}?access_token=jxP8gQxK0VAjiYCOQaBgBA82G-N5nfTNIEAKs6fuuwM&page=#{page_no.to_i}"
end

#API実行｜jsonデータを配列へ変換し返す（1980年まで入れた）
def request_api(url = "https://api.annict.com/v1/works?access_token=jxP8gQxK0VAjiYCOQaBgBA82G-N5nfTNIEAKs6fuuwM\&filter_season=2021-autumn\&page=2")
  req_url = URI.parse(url)
  json = Net::HTTP.get(req_url)
  response = JSON.parse(json)
end

#次のページをリクエストする
def get_next_page(page_no:, table_name:)
  req_url  = get_change_req_url(table: table_name, page_no: page_no)
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
  null_list = []
  while !response["next_page"].nil?
    response[req_name].each_with_index do |data, index|
      #各モデルを追加する
      case req_name
      #characterとcastsは「casts」リクエストで行う  
        when "casts"  then
          add_cast_data(data, null_list)
          # add_character_data(data, null_list) 
        when "organizations" then add_organization_data(data)
        when "staffs" then add_staffs_data(data)
        when "series" then add_series_data(data, null_list)
        when "works"  then add_work_data
      end

      if index == NEXT_PAGE_NO
        page_no += 1
        count += 1
        response = get_next_page(page_no: page_no, table_name: req_name)
        puts "デバッグ#{count}/ページNO=#{page_no}"
      end
    end
  end

  return true
end

#モデルからあいまい検索してくる
def find_by_like_from_model(model_name:, fields:, conditions:)
  model_name.find_by("#{fields} like ?", "%#{conditions.slice(0..3)}%")
end

#先頭から4文字抽出した検索結果を配列で取得
def where_like_from_model(model_name:, fields:, conditions:)
  model_name.where("#{fields} like ?", "%#{conditions.slice(0..4)}%")
end

#csvファイルへ書き出す（追記モード）
def common_write_csv_file_model_data(parent_model:, child_model:, csv_file_path:, mode: "worktag")
  null_list = Hash.new
  csv_data = CSV.open("db/data/csv/#{csv_file_path}", "w") do |csv|
    column_names = %w(work_id work_title danime_title tag_id tag_name) if mode =="worktag"
    column_names = %w(work_id cast_id work_title cast_title cast_name) if mode =="workcast"
    column_names = %w(work_id work_title child_id child_title image_url) if mode =="danime_images"
    column_names = %w(id  title) if mode.nil?
    #最初の1行目にカラム設定
    csv << column_names
    
    # column_valuesに代入するカラム値を定義します。
    # parent_model.all.each do |parent|
      # child_data = child_model.where(title: parent.title)
      # child_data.each do |child|
        # tag = Tag.find_by(id: child.tag_id)
        # if !child.nil?
          # column_values = [
            # parent.id,
            # parent.title,
            # child.title,
            # child.tag_id,
            # tag.name,
          # ]
          # csv << column_valueshは表の行に入る値を定義します。
          # csv << column_values
        # end
      # end
    # end

    #danime_imagesの整合性を確認するためのロジック
    parent_model.find_each do |parent|
      child_data = child_model.find_by(title: parent.title)
      if child_data.nil?
        null_list[parent.id] = parent.title
      else
        column_values = [
          parent.id,
          parent.title,
          child_data.id,
          child_data.title,
          child_data.image_url,
        ]
        # csv << column_valueshは表の行に入る値を定義します。
        csv << column_values
      end
    end
  end
  puts "ループ終了です〜"
  puts "作品ID：#{null_list.keys} 作品名：#{null_list.values}"
  puts "タイトルが合致しなかった件数：#{null_list.size}"
end

#データ一覧をcsvファイルへ出力する
def create_csv_data(columns: nil)
  works = Work.all
  csv_data = CSV.open("db/data/csv/#{CSV_FILE_WORKS_LIST}", "w") do |csv|
    column_names = %w(work_id tag_id danime_title work_title)
    column_names = %w(id  title) if columns.nil?
    #最初の1行目にカラム設定
    csv << column_names
    
    # column_valuesに代入するカラム値を定義します。
    works.each do |work|
      danimes = where_like_from_model(model_name: Danime, fields: "title", conditions: work.title)
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

#データ一覧をcsvファイルへ出力する
def create_csv_data(model:, columns: nil)
  worktags = model.all
  csv_data = CSV.open("db/data/csv/#{CSV_FILE_WORK_SERIES_LIST}", "w") do |csv|
    column_names = %w(id work_id tag_id)
    column_names = %w(id  title) if columns.nil?
    #最初の1行目にカラム設定
    csv << column_names
    
    #column_valuesに代入するカラム値を定義します。
    worktags.each do |work|
      column_values = [
        work.id,
        work.work_id,
        work.tag_id,
        work.tag_checked,
      ]
      # csv << column_valueshは表の行に入る値を定義します。
      csv << column_values
    end
  end
end

#モデルにないデータを書き出す
def create_csv_null_list(list_item:, columns: nil, mode: "series")
  csv_file_path = mode == "series" ? CSV_FILE_WORK_SERIES_LIST : CSV_FILE_CAST_LIST
  csv_file_path = mode == "characters" ? CSV_FILE_CHARACTER_LIST : CSV_FILE_CAST_LIST
  csv_data = CSV.open("db/data/csv/#{csv_file_path}", "w") do |csv|
    column_names = %w(work_id cast_id work_title cast_title cast_name) if mode == "workcast"
    column_names = %w(id  title) if columns.nil?
    #最初の1行目にカラム設定
    csv << column_names
  
    list_item.each_with_index do |item, i|
      column_values = [
        i+1,
        item,
      ]
      # csv << column_valueshは表の行に入る値を定義します。
      csv << column_values
    end
  end
end

#WEBから画像を取得して保存する
def get_image_request_download
  Work.all.each do |work|
    url = work.facebook_og_image_url
    if !url.blank?
      #バイナリデータ形式で書き込む（画像がなっかたら新規作成）
      open("./app/assets/images/work_#{work.id}.jpg", 'wb') do |file|
        begin
          open(url) do |image|
            puts "ID：#{work.id} /タイトル：#{work.title} /URL：#{url}"
            file.write(image.read)
          end
        rescue => e
          error_msg(e)
          next
        end
        
      end
    end 
  end
end

private

#workIDの存在をチェックし保存を実行する
def add_series_data(series, null_list)
  begin
    work = Work.find_by("title LIKE ?", "#{series["name"]}%")
    if !work.nil?
      create_series(work, series)
    else
      null_list << series["name"]
      create_csv_null_list(list_item: null_list, mode: "series")
    end
  rescue => e
    error_msg(e)
  end
end

#シリーズのデータを作成する
def create_series(work, series)
  Series.find_or_create_by(
    work_id: work.id,
    name: series["name"]
  )
  puts "シリーズ名：#{series["name"]}"
end

#キャラクターの追加
def add_character_data(character, null_list)
  puts character["character"]["name"] if character["character"]["name"] == "日南葵"
  puts "作品名がNILLです！！" if character["work"]["title"].blank?

  work = Work.find_by(title: "#{character["work"]["title"]}")
  char =  Character.find_by(name: "#{character["character"]["name"]}")
  if work.nil?
    null_list << character["work"]["title"]
    create_csv_null_list(list_item: null_list, mode: "characters")
  end
  if char.nil? && !work.nil?
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
  end
end

#キャストの追加
def add_cast_data(cast, null_list)
  character = Character.find_by(name: "#{cast["character"]["name"]}")
  cast_data = Cast.find_by(work_title: "#{cast["work"]["title"]}")
  if character.nil?
    null_list << cast["work"]["title"]
    create_csv_null_list(list_item: null_list, columns: nil, mode: "cast")
  end
  if cast_data.nil? && !character.nil?
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
  end
  puts "#{character&.id}：キャスト：#{cast["person"]["name"]}：タイトル：#{cast["work"]["title"]}：キャラクター:#{cast["character"]["name"]}"
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
    puts "ID#{work&.id}：役職：#{staff["name"]}：スタッフ#{staff["role_text"]}| #{staff["role_other"]}：タイトル：#{staff["work"]["title"]}"

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

#アニメデータの追加（論理削除カラム追加）
def add_work_data
  table_name = "works"
  response = request_api
  data = nil
  response[table_name].each do |work|
    data = Work.find_by(title: "#{work["title"]}")
    if data.nil?
      Work.create(
        season_name: work["season_name"],
        season_name_text: work["season_name_text"],
        season_year: work["season_name"],
        title: work["title"],
        episodes_count: work["episodes_count"],
        image_thumbnail: "",
        facebook_og_image_url: work["images"]["facebook"]["og_image_url"],
        released_at: work["released_at"],
        media: work["media"],
        media_text: work["media_text"],
        official_site_url: work["official_site_url"],
        twitter_hashtag: work["twitter_hashtag"],
        twitter_image_url: work["images"]["twitter"]["twitter_image_url"].nil? ? "" : work["images"]["twitter"]["twitter_image_url"],
        twitter_username: work["twitter_username"],
        recommended_image_url: work["images"]["recommended_image_url"].nil? ? "" : work["images"]["recommended_image_url"],
        wikipedia_url: work["wikipedia_url"],
        is_deleted: true
      )
    else
      #更新処理
      data.update(
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
    end
  end
end

#アニメと声優のデータを紐付ける
def add_workcasts_data(work, cast)
  if !work.nil? && !cast.nil?
    Workcast.find_or_create_by(
      work_id: work.id,
      cast_id: cast.id
    )
  end
  puts "ID：#{work.id}:#{cast.id}:title:#{work.title}:work_title:#{cast.work_title}:CV#{cast.name}"
end

#アニメとタグのデータを紐付ける
def add_worktags_data(work, danime, tag_ids)
  Worktag.find_or_create_by(
    work_id: work.id,
    tag_id:  danime.tag_id,
    tag_checked: false
  )
  tag_ids << danime.tag_id
  puts "work_id :#{work.id} :work_title :#{work.title} :danime_title :#{danime.title} :tag_ids :#{tag_ids}"
end

#workテーブルと各関連モデルを紐付け、データを追加する
def add_work_relation_model(parent_model:, child_model:, fields:, model_name:)
  parent_model.find_each do |parent|
    tag_ids = []
    # child_model.where(title: parent.title).each do |child|
    child_model.where(work_title: "#{parent.title}").each do |child|
      
      case model_name.name
        when "Worktag" then
          add_worktags_data(parent, child, tag_ids)
        when "Workcast" then
          add_workcasts_data(parent, child)
      end
    end
  end
end

#dbを更新する(1000件ずつ取得する)
def update_model(parent_model:Work, child_model:)
  count = 1
  null_list = Hash.new
  #1000件ごとにデータを取得しまわす
  parent_model.find_each do |parent|
    child_data = child_model.find_by(title: parent.title)
    #すでに存在する場合は作成しない
    if child_data.nil?
      null_list[parent.id] = parent.title
    else
      parent.update(image_thumbnail: child_data.image_url.strip)
      puts "デバッグ:#{count} (W)作品名：#{parent.title} イメージURL：#{child_data.image_url} (D)作品名：#{child_data.title}"
    end
    count += 1
  end
  puts "ループ終了します〜"
  puts "作品が合致しなかったタイトル　ID：#{null_list.keys} 作品名：#{null_list.values}"
  puts "作品が合致しなかったタイトル件数：#{null_list.size}"
end

#worksのimage_thumbnailを一括で更新する
def update_image_thumbnail(csv_file_path:)
  count = 1
  CSV.foreach("db/data/csv/#{csv_file_path}", headers: true) do |row|
    work = Work.find_by(title: row["title"])
     work.update(image_thumbnail: row["image_url"]) if !work.nil? && work.image_thumbnail.blank?
     count += 1
     
     puts "デバッグ#{count}/タグ名：#{row["title"]}"
  end
end

#重複したアニメタイトルを取得し削除フラグを一括更新する
def duplicate_title
  data = []
  work_id = [] 
  duplicate_title = Work.select(:title).group(:title).having('count(*) > ?', 1).count

  duplicate_title.keys.each do |works|
    data << Work.find_by(title: works)
  end

  data.sort.each {|work_data| work_data.update(is_deleted: false)}
  data.sort.each do |work_data|
    puts "作品：#{work_data.id}　タイトル：#{work_data.title} 年代：#{work_data.season_name_text}"
    work_id << work_data.id
  end

  puts "更新完了です~"
  puts "ID一覧：#{work_id}"
end

#CSVからdbへ保存する
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
  elsif tags == "danimes"
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
  else
    CSV.foreach("db/data/csv/#{CSV_FILE_IMAGE_URL_25BUTAI}", headers: true) do |row|
      DanimeImage.find_or_create_by(
        title: row["title"],
        image_url: row["url"],
      )
      puts "デバッグ#{count} タイトル:#{row["title"]}：url：#{row["url"]}"
      count += 1
    end
  end
end

def include_protocol?
  count = 1
  blank_count = 0
  work_null_list = Hash.new
  array = ["http", "https"]
  Work.find_each do |work|
    if !work.image_thumbnail.blank?
      image_url = work.image_thumbnail.split("/").include?(array)
      # image_url = array.any? {|h| w.include?(h)}
      if image_url
        work_null_list[work.id] = work.image_thumbnail
        count += 1
      end
    else
      blank_count += 1
    end
  end
  puts "プロトコルが含まれてないない：#{count}件"
  puts "image_thumbnailがブランク：#{blank_count}件"
  puts "プロトコルが含まれてないないID：#{work_null_list}"
end

#アニメを追加
# add_work_data

#モデルをAPIを実行し追加（mainメソッド）
# common_add_model_data(name: "casts")

#csvファイルのdanimeのimageデータをモデルへ追加
# open_csv_model_create("image_url")

#tagsやdanimesのデータを引数によって追加
# open_csv_model_create

#関連付けされたモデルのデータを追加する
# add_work_relation_model(parent_model: Work, child_model: Cast, fields: "work_title", model_name: Workcast)
# add_work_relation_model(parent_model: Work, child_model: Danime, fields: "title", model_name: Worktags)
# add_work_relation_model(Work, Danime, "title", Worktag)


#データの比較検証用　csvファイルへ新規データ書き込み
# common_write_csv_file_model_data(parent_model: Work, child_model: Cast,  csv_file_path: CSV_FILE_WORKS_CAST_LIST, mode: "NOT_NULL")
# common_write_csv_file_model_data(parent_model: Work, child_model: Danime,csv_file_path: CSV_FILE_WORK_TAG_LIST_DESTROY_BEFORE_LIST, mode: "worktag")
# common_write_csv_file_model_data(parent_model: Work, child_model: DanimeImage,csv_file_path: CSV_FILE_URL_IMAGE_LIST, mode: "danime_images")

#検証用　モデルのリレーションデータ一覧をcsvファイルへ出力する
# create_csv_data(model: Worktag, columns: "worktag")

#URLよりimageをダウンロードしassets配下へ保存する
# get_image_request_download

#モデルの既存データを更新する（まだ途中）
# update_model(child_model: DanimeImage)

#アニメタイトルの重複データを取得する
# duplicate_title
# duplicate_name

#サムネイルの更新
# update_image_thumbnail(csv_file_path: CSV_FILE_IMAGE_URL_ACTION_BATTLE)

#プロトコルがURLに含まれているかどうか
include_protocol?