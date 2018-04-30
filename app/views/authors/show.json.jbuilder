json.extract! @author, :id, :name, :dir_name, :tag_list, :rating
json.image @author.image.attached? ? url_for(@author.image.variant(resize: "400x800")) : ''


files = []
set_dir(AUTHOR_DIR, @author)
unless Dir.pwd == AUTHOR_DIR
  Dir.children(Dir.pwd).sort.each_with_index do |file, idx|
    index = idx - 1
    if file[0] != '.'
      files << {name: '', rating: nil, tag_list: []}
      files[index][:name] = file
      if @author.archives.any?
        @author.archives.each do |archive|
          if file == archive.name
            files[index][:rating] = archive.rating || 0
            files[index][:tag_list] = archive.tag_list
          end
        end
      end
    end
  end
end

json.files files
json.all_tag_list @all_names
