class Archive < ApplicationRecord
  acts_as_taggable
  belongs_to :owner, polymorphic: true
  include Tagable

end
