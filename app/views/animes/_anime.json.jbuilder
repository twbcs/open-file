json.extract! anime, :id, :name, :dir_name, :file_count
json.url anime_url(anime)
json.image anime.image.attached? ? url_for(anime.image.variant(resize: "140x198!")) : ''
