require './app'
require 'rspec'
require 'rack/test'

describe 'The Url Model' do
  it 'should create a short url' do
    url = Url.create(original_url: 'http://google.com')
    expect(url.short_url.length).to eq(6)
  end

  it 'should increment clicks' do
    url = Url.create(original_url: 'http://google.com')
    url.increment_clicks
    expect(url.clicks).to eq(1)
  end
end
