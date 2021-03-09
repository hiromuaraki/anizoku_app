class Tag < ApplicationRecord
  has_many :worktags, dependent: :destroy
  has_many :works, through: :worktags

  #タグIDを一覧を取得する 随時更新
  def self.tag_id
    tag_id = {
      #コメディ/ギャグ
      comedy_gyg: 1,
      #SF/ファンタジー
      sf_fantasy: 2,
      #ロボット/メカ
      robbot_meka: 3,
      #日常/ほのぼの
      every_day_honobno: 4,
      #アクション/バトル
      action_battle: 5,
      #恋愛/ラブコメ
      love_come: 6,
      #スポーツ/競技
      sports: 7,
      #ホラー/サスペンス/ミステリー
      hora_mistery: 8,
      #歴史/戦記
      history: 9,
      #戦争/ミリタリー
      war_miritary: 10,
      #ドラマ/青春
      dorama_youth: 11,
      #ショート
      short: 12,
      #青春
      youth: 13,
      #女性に人気のアニメ
      womans_popular: 14,
      #男性に人気のアニメ
      mans_popular: 15,
      #なろう
      narou: 16,
      #ラノベ
      ranobe: 17,
      #幼女
      rori: 18,
      #ショタ
      shota: 19,
      #闇堕ち
      darak: 20,
      #萌え
      moe: 21,
      #超超萌え萌え
      super_moemoe: 22,
      #主人公最強
      hero_strong: 23,
      #百合
      yuri: 24,
      #BL
      bl: 25,
      #爆笑
      warai: 26,
      #鬱
      utsu: 27,
      #グロ
      guro: 28,
      #学園
      school: 29,
      #まんがタイムきらきら
      mannga_time_kirara: 30,
      #お仕事系
      work: 31,
      #タイムリープ
      time_leep: 32,
      #頭脳系/心理戦
      brain_psychology: 33,
      #泣ける
      cry: 34,
      #ヤンデレ
      yandere: 35,
      #アイドル
      idol: 36,
      #アニメ入門
      anime_tutorial: 37,
      #癒し
      iyashi: 38,
      #人気
      popular: 39,
      #ゲーム原作
      game: 40,
      #夏休みに観たいアニメ
      summer_vacation: 41,
      #春休みに観たいアニメ
      spring_vacation: 42,
      #冬休みに観たいアニメ
      winter_vacation: 43,
      #クリスマス
      xsmas: 44,
      #バレンタイン
      valentin: 45,
      #元気がない時に観たい
      feel_sad: 46,
      #現実逃避したい時に観たい
      real_esape: 47,
      #管理人のおすすめ
      admin_recommended: 48,
      #ツンデレ
      tsundere: 49,
      #エロゲー
      eroge: 50,
      #妹
      sister: 51,
      #異世界
      another_world: 52,
      #異世界転生
      another_world_tensei: 53,
      #みんなのおすすめ
      everyone_recommended: 54,
      #ハーレム
      harrem: 55,
      #勉強
      study: 56,
    }
  end

  #タグ一覧を返す
  def self.tag_list
    tags = Tag.all
  end

end
