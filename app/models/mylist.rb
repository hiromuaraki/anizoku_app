class Mylist < ApplicationRecord
  belongs_to :work
  belongs_to :user

  #マイリストの状態
  MY_LIST_STATUS = {
    "add": 0,
  }
end
