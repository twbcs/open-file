class Archive < ApplicationRecord
  acts_as_taggable
  belongs_to :owner, polymorphic: true

end
