# frozen_string_literal: true

BookingSystem::RoomBooking.default_observers = [
  ::Observers::EmailNotifier.new,
  ::Observers::LoggingNotifier.new
]
