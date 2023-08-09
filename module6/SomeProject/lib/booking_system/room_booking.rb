# frozen_string_literal: true

module BookingSystem
  class RoomBooking
    include Observable

    def update_price
      changed
      notify_observers(:price_updated)
      ActiveSupport::Notifications.instrument('room_booking.update_price', action: :price_update)
    end
  end
end
