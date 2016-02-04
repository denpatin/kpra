# encoding: utf-8

require 'nokogiri'
require 'httpclient'
require 'action_view'

# For testing purposes
film = 431_148

# Types of reviews
emotions = %w(good bad neutral)

emotions.each do |emotion|
  # Writing separate file for each review
  open("#{film}_#{emotion}.txt", 'w+') do |file|
    url = "http://www.kinopoisk.ru/film/#{film}/ord/rating/status/#{emotion}/"

    # Simulating Chrome browser so that Kinopoisk doesn't block our requests
    get_url = HTTPClient.new.get url,
                                 nil,
                                 'User-Agent'.to_sym =>
                                     'Mozilla/5.0 (X11; Linux x86_64; rv:38.9)
                                     AppleWebKit/537.36 (KHTML, like Gecko)
                                     Chrome/48.0.2564.103
                                     Safari/537.36',
                                 'Accept-Encoding'.to_sym => 'deflate'
    reviews = Nokogiri::HTML get_url.body.encode('utf-8')

    # The path to the reviews in the HTML DOM
    reviews_path = '.clear_all .reviewItem table ._reachbanner_'

    corpus = []

    reviews.css(reviews_path).each do |review|
      content = review.inner_html

      # Remove all html tags
      wo_html = ActionView::Base.full_sanitizer.sanitize(content)

      # Replace carriage return, newlines, and dashes
      corpus << wo_html.gsub('&#13;', '').tr("\u0097", '-').gsub(/[\n]+/, ' ')
    end

    file.puts corpus
  end
end
