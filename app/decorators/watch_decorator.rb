# frozen_string_literal: true

module WatchDecorator
  
  def type_status(watch)
    status = 0
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
    
    return status
  end

end
