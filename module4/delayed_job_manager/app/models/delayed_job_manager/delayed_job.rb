module DelayedJobManager
  class DelayedJob < ApplicationRecord
    self.table_name = "delayed_jobs"
  end
end