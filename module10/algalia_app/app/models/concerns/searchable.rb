# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do

    include AlgoliaSearch

    algoliasearch  do
      attribute :title, :description

      searchableAttributes ['title', 'description']
    end

    def self.q_search(query)
      if query
        search(query)
      else
        all
      end
    end
  end
end
