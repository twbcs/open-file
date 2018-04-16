class Author < Carrier
  has_many :archives, as: :owner
end
