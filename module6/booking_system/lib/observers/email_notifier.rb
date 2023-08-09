# frozen_string_literal: true

module Observers
  class EmailNotifier
    def update(event)
      case event
      when :room_booked
        puts 'Sending email notification: Room booked'
      when :room_available
        puts 'Sending email notification: Room became available'
      end
    end
  end
end
