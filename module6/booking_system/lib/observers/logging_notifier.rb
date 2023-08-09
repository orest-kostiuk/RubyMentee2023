# frozen_string_literal: true

module Observers
  class LoggingNotifier
    def update(event)
      puts "Logging event: #{event}"
    end
  end
end