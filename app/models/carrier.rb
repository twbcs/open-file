class Carrier < ApplicationRecord
  # Gutentag::ActiveRecord.call self
  acts_as_taggable
  has_one_attached :image
end
