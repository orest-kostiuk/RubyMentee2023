# frozen_string_literal: true

module BookingSystem
  class RoomBooking
    include Observable

    cattr_accessor :default_observers

    def initialize
      @observers = self.class.default_observers || []
    end

    def update_price
      changed
      notify_observers(:price_updated)
      ActiveSupport::Notifications.instrument('room_booking.update_price', action: :price_update)
    end
  end
end
