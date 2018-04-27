json.extract! @anime, :id, :name, :dir_name, :tag_list
json.image @anime.image.attached? ? url_for(@anime.image.variant(resize: "400x800")) : ''


files = []
set_dir(ANIME_DIR, @anime)
unless Dir.pwd == ANIME_DIR
  Dir.children(Dir.pwd).sort.each_with_index do |file, idx|
    index = idx - 1
    if file[0] != '.'
      files << {name: '', rating: nil, tag_list: []}
      files[index][:name] = file
    end
  end
end

json.files files
json.all_tag_list @all_names
