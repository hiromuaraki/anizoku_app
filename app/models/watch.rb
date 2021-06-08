class Watch < ApplicationRecord
  belongs_to :work
  belongs_to :user

  #視聴ステータス
  #見た:0 見てる:1 見てない:2
  STATUS = {
    "watched": 0,
    "watching": 1,
    "not_watched": 2,
    "want_watch": 3
  }

  #視聴ステータスがあるアニメのみセットする
  def self.type_status_equal(watches, work_id)
    status = ""
    watches.each do |watch|
      next if watch.work_id != work_id
      case watch.status
      when Watch::STATUS[:watched]
        status = "watched"
      when Watch::STATUS[:watching]
        status = "watching"
      when Watch::STATUS[:not_watched]
        status = "not_watched"
      when Watch::STATUS[:want_watch]
        status = "want_watch"
      end
    end
    return status
  end

  #タブ切り替えを制御するモードを返す
  def self.status_mode(mode)
    ret_mode = 0
    case mode
      when Watch::STATUS[:watched].to_i then ret_mode = Watch::STATUS[:watched].to_i
      when Watch::STATUS[:watching].to_i then ret_mode = Watch::STATUS[:watching].to_i
      when Watch::STATUS[:not_watched].to_i then ret_mode = Watch::STATUS[:not_watched].to_i
      when Watch::STATUS[:want_watch].to_i then ret_mode =  Watch::STATUS[:want_watch].to_i
    end
    return ret_mode

  end

end
