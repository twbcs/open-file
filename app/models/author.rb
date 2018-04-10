class Author < ApplicationRecord
  Gutentag::ActiveRecord.call self
  has_one_attached :image
end
