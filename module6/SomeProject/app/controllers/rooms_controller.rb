# frozen_string_literal: true

require_dependency 'booking_system/room_booking'

class RoomsController < ApplicationController
  before_action :setup_room_booking

  def book
    @room_booking.book
    render plain: 'Room booked'
  end

  def available
    @room_booking.available
    render plain: 'Room became available'
  end

  def discount
    @room_booking.discount
    render plain: 'Room has a discount'
  end

  def update_price
    @room_booking.update_price
    render plain: 'Room price updated'
  end

  private

  def setup_room_booking
    @room_booking = BookingSystem::RoomBooking.new
  end
end