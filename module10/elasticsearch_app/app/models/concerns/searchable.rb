# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings do
      mapping dynamic: false do

        indexes :title, type: 'text'
        indexes :description, type: 'text'
      end
    end

    def self.search(query)
      if query
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: %w[title description]
            }
          }
        }
      ).results.map(&:_source)
      else
        all
      end
    end
  end
end
