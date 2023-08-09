# frozen_string_literal: true

require_dependency 'booking_system/room_booking'

class RoomsController < ApplicationController
  def book
    room_booking = BookingSystem::RoomBooking.new
    room_booking.add_observer(::Observers::EmailNotifier.new)
    room_booking.add_observer(::Observers::LoggingNotifier.new)

    room_booking.book
    render plain: 'Room booked'
  end

  def available
    room_booking = BookingSystem::RoomBooking.new
    room_booking.add_observer(::Observers::EmailNotifier.new)
    room_booking.add_observer(::Observers::LoggingNotifier.new)

    room_booking.available
    render plain: 'Room became available'
  end

  def discount
    room_booking = BookingSystem::RoomBooking.new
    room_booking.add_observer(::Observers::EmailNotifier.new)
    room_booking.add_observer(::Observers::LoggingNotifier.new)

    room_booking.discount
    render plain: 'Room has a discount'
  end

  def update_price
    room_booking = BookingSystem::RoomBooking.new
    room_booking.add_observer(::Observers::EmailNotifier.new)
    room_booking.add_observer(::Observers::LoggingNotifier.new)
    room_booking.update_price
    render plain: 'Room price updated'
  end
end
