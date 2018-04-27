json.extract! movie, :id, :name, :dir_name
json.url movie_url(movie)
json.image movie.image.attached? ? url_for(movie.image.variant(resize: "140x198!")) : ''
