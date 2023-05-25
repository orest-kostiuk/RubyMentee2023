require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "urls.sqlite3"}

require './models/url'

get '/' do
  @urls = Url.order('created_at DESC')
  erb :index
end

post '/urls' do
  @url = Url.new(original_url: params[:original_url])
  if @url.save
    redirect '/'
  else
    @error = "Invalid URL"
    @urls = Url.order('created_at DESC')
    erb :index
  end
end

get '/:short_url' do
  url = Url.find_by(short_url: params[:short_url])
  if url
    url.increment_clicks
    redirect url.original_url
  else
    @error = "URL not found"
    erb :index
  end
end
