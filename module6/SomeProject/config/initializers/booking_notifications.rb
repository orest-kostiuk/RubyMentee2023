# frozen_string_literal: true

ActiveSupport::Notifications.subscribe('room_booking.update_price') do |*args|
  puts 'Email notification: Price updated'
end
