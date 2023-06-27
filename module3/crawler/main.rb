# frozen_string_literal: true

require 'sqlite3'
require 'net/http'
require 'addressable'
require 'socket'
require 'uri'
require 'parallel'
require 'async'

urls = %w[https://www.monocubed.com/ruby-on-rails-vs-python-which-backend-technology-is-superior/
          https://www.coursera.org/blog/ruby-vs-python-pros-cons https://blog.appacademy.io/ruby-on-rails-vs-python/
          https://www.codecademy.com/resources/blog/what-is-ruby-on-rails
          https://essencesolusoft.com/ruby-on-rails-vs-python/
          https://www.emveep.com/blog/ruby-on-rails-vs-python-for-web-development
          https://habr.com/en/post/490466/
          https://www.botreetechnologies.com/blog/ruby-on-rails-vs-python/
          https://www.educative.io/blog/ruby-tutorial-for-python-programmers
          https://www.codecademy.com/resources/blog/15-ruby-on-rails-interview-questions
          https://www.computerscience.org/resources/ruby-on-rails-resources/
          https://www.ideamotive.co/blog/python-vs-ruby-for-web-development
          https://www.geeksforgeeks.org/ruby-on-rails-introduction/
          https://searchsoftwarequality.techtarget.com/definition/Ruby-on-Rails
          https://careerkarma.com/blog/ruby-on-rails-vs-python-and-django/
          https://ithouse.io/blog/ruby-on-rails-opensource-and-other-technologies-used-by-it-house
          https://www.freecodecamp.org/news/why-you-should-learn-ruby-on-rails/
          https://slate.com/technology/2014/03/ruby-ruby-on-rails-and-why-the-disappearance-of-one-of-the-worlds-most-beloved-computer-programmers.html https://syndicode.com/2019/03/08/ruby-vs-ruby-on-rails-and-other-languages-5-things-to-know/ https://www.techtarget.com/search/ruby-on-rails/].freeze

def download_and_save(url)
  # uri = URI.parse(url)
  # content = Net::HTTP.get(uri)
  # file_name = "#{uri.host}_#{uri.path.gsub('/', '_')}.html"
  # File.write(file_name, content)

  matrix_multiplication(200)
end

def matrix_multiplication(n)
  matrix_a = Array.new(n) { Array.new(n) { rand(0..10) } }
  matrix_b = Array.new(n) { Array.new(n) { rand(0..10) } }
  result = Array.new(n) { Array.new(n, 0) }

  (0...n).each do |i|
    (0...n).each do |j|
      (0...n).each do |k|
        result[i][j] += matrix_a[i][k] * matrix_b[k][j]
      end
    end
  end
end

# start_time = Time.now
# threads = []
#
# urls.each do |url|
#   threads << Thread.new do
#     download_and_save(url)
#   end
# end
#
# threads.each(&:join)
# puts "Execution time (Threads): #{Time.now - start_time} seconds"
#
# start_time = Time.now
# fibers = []
#
# urls.each do |url|
#   fibers << Fiber.new do
#     download_and_save(url)
#   end
# end

# fibers.each(&:resume)
# puts "Execution time (Fibers): #{Time.now - start_time} seconds"

15.times do |i|
  start_time = Time.now

  Parallel.each(urls, in_processes: i + 1) do |url|
    download_and_save(url)
  end

  puts "Execution time (Processes #{i + 1}): #{Time.now - start_time} seconds"
end

# start_time = Time.now
#
# Async do
#   urls.each do |url|
#     Async do
#       download_and_save(url)
#     end
#   end
# end
#
# puts "Execution time (Async): #{Time.now - start_time} seconds"
