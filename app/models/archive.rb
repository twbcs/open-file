class Archive < ApplicationRecord
  Gutentag::ActiveRecord.call self
  belongs_to :owner, polymorphic: true

end
