require 'nokogiri'
require 'httpclient'

def get_content(url)
  browser = 'Chrome/41.0.2228.0'
  encoding = 'deflate'
  http_params = { 'User-Agent' => browser, 'Accept-Encoding' => encoding }
  client = HTTPClient.new('http://proxy.t-systems.ru:3128')
  response = client.get url, nil, http_params
  fail Class.new StandardError, 'Not accessible!' unless response.status == 200
  Nokogiri::HTML response.body.encode('utf-8')
end

def get_reviews(id, mood, per_page, mode)
  url = "http://www.kinopoisk.ru/film/#{id}/ord/rating/status/#{mood}/perpage/#{per_page}"
  content = get_content(url)
  unless content.search('.pagesFromTo').first.nil?
    count = content.search('.pagesFromTo').first.text[/\d+$/].to_i
    open("#{id}_#{mood}.txt", 'w') { |f|
      # per_page = count < 10 ? count : content.search('.show select option[last()]').first.text.to_i
      # review_url = "http://www.kinopoisk.ru/film/#{id}/ord/rating/status/#{mood}/perpage/#{per_page}"
      # if count > 200
      page = count / per_page + (count % per_page != 0 ? 1 : 0)
      if page == 1
        case mode
        when 'quick'
          STDOUT.write "\r#{count} of #{count} reviews extracted"
          f.puts content.search(".reviewItem table .brand_words p span").text
        when 'precise'
          [*1..count].each do |review|
            STDOUT.write "\r#{review} of #{count} reviews extracted"
            f.puts content.search(".reviewItem table .brand_words p span")[review-1].text
          end
        else
          puts 'Nonexistent mode!'
        end
      else
        [*1..page].each do |page_review|
          page_content = get_content("#{url}/page/#{page_review}")
          reviews_left = count-per_page*(page_review-1) > per_page ? per_page : count % per_page
          case mode
          when 'quick'
            STDOUT.write "\r#{(page_review-1)*per_page+(count % per_page)} of #{count} reviews extracted"
            f.puts page_content.search(".reviewItem table .brand_words p span").text
          when 'precise'
            [*1..reviews_left].each do |review|
              STDOUT.write "\r#{(page_review-1)*per_page+review} of #{count} reviews extracted"
              f.puts page_content.search(".reviewItem table .brand_words p span")[review-1].text
            end
          else
            puts 'Nonexistent mode!'
          end
        end
      end
    }
    puts
  else
    puts 'No reviews!'
  end
end

# p pages = count / per_page + (count % per_page != 0 ? 1 : 0)

# count >= 200 ? 200 : [10,25,50,75,100,200].each { |p| next if p < count; break p }

# Further review processing
# YandexMystem::Simple.stem(review).to_h.values.flatten.join(' ').scan(/[a-zа-яеё]+/i).inject(Hash.new(0)){ |f, w| f[w] += 1; f }.to_a.sort_by{ |x| -x[1] }[0,10].each{ |w, f| puts "%-20s%d" % [w, f] }

# YandexMystem::Simple.stem(File.open(ARGV[0]).read).to_h.values.inject(Hash.new(0)){ |f, w| f[w] += 1; f }.to_a.sort_by{ |x| -x[1] }[0,10].each{ |w, f| puts "%-20s%d" % [w, f] }
