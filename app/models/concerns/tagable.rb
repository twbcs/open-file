module Tagable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_tags
      Rails.cache.fetch("#{name.downcase}_tags", expires_in: 20.minutes) do
        tag_counts_on(:tags).pluck(:name)
      end
    end
  end
end
