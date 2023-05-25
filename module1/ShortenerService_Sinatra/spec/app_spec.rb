require './app'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application

describe 'The Sinatra App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should allow URL shortening" do
    post '/urls', params={original_url: 'http://google.com'}
    expect(last_response.redirect?).to be(true)
    follow_redirect!
    expect(last_response.body).to include('google.com')
  end
end
