module ApplicationHelper
  def url_name(link)
    name = {'authors': '作者', 'animes': '動畫', 'movies': '電影'}
    name[link.to_sym]
  end
end
