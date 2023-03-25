module ApplicationHelper
  def default_meta_tags
    {
      site: 'あ！にぞく',
      title: 'anizoku',
      reverse: true,
      charset: 'utf-8',
      description: 'description',
      keywords: 'キーワード',
      canonical: request.original_url,
      separator: '|',
      icon: [
        # { href: image_url('favicon.ico'), size: "200x200"},
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'あ！にぞく', # もしくは site_name: :site
        title: 'anizoku', # もしくは title: :title
        description: 'description', # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url("Free_Sample_By_Wix.jpeg"),
        locale: 'ja_JP',
      }, 
      twitter: {
        card: 'summary',
        site: "@#{current_user&.name}",
      }
    }
  end
end
