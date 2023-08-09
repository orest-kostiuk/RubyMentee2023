# frozen_string_literal: true

Rails.application.routes.draw do
  get 'rooms/book'
  get 'rooms/available'
  get 'rooms/discount'
  get 'rooms/update_price'
end
