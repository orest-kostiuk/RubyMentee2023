# frozen_string_literal: true
require "active_support"
require_relative 'booking_system/version'
require_relative 'booking_system/room_booking'
require_relative 'observers/logging_notifier'
require_relative 'observers/email_notifier'

module BookingSystem
  class Error < StandardError; end
  # Your code goes here...
end
