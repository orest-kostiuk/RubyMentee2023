# frozen_string_literal: true

require 'observer'

module BookingSystem
  class RoomBooking
    include Observable

    def book
      changed
      notify_observers(:room_booked)
    end

    def available
      changed
      notify_observers(:room_available)
    end

    def discount
      changed
      notify_observers(:discount_applied)
    end

    def update_price
      changed
      notify_observers(:price_updated)
    end
  end
end
