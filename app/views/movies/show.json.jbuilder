json.extract! @movie, :id, :name, :dir_name, :tag_list
json.image @movie.image.attached? ? url_for(@movie.image.variant(resize: "400x800")) : ''


files = []
set_dir(MOVIE_DIR, @movie)
unless Dir.pwd == MOVIE_DIR
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
