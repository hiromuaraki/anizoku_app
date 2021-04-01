Ransack.configure do |config|
  # 述語名
config.add_predicate 'has_every_term',
  # Arelの述語を指定。全ての要素に対してLIKE検索したいからatches_allを使うよ。
  arel_predicate: 'matches_all',
  # インプットの整形。半角スペース区切りの文字列を、配列にして部分一致するようにしてるよ。
  formatter: proc { |v| v.split.map { |t| "%#{t}%" } }
end