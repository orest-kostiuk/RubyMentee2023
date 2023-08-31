class ArticlesMaterializedView < ApplicationRecord
  self.table_name = 'articles_materialized_view'
  self.primary_key = :id
end
