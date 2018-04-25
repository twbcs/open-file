json.extract! author, :id, :name, :dir_name
json.url author_url(author)
json.image author.image.attached? ? url_for(author.image.variant(resize: "140x198!")) : ''
