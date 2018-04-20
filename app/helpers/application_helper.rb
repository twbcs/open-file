module ApplicationHelper
  def url_name(link)
    name = {'authors': '作者', 'animes': '動畫', 'movies': '電影'}
    name[link.to_sym]
  end

  def set_dir(dir, object)
    Dir.chdir("#{dir}/#{object.dir_name}")
  rescue => ex
    Dir.chdir(dir)
  end
end
