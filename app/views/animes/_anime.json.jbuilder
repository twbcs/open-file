json.extract! anime, :id, :name, :dir_name
json.url anime_url(anime)
json.image anime.image.attached? ? url_for(anime.image.variant(resize: "140x198!")) : ''
