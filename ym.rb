start = Time.now

require 'yandex_mystem'

result = Array.new
File.open(ARGV[0]).read.scan(/[a-zа-яеё-]{20,}/i).each do |word|
	result << YandexMystem::Simple.stem(word).values
end

result.flatten.inject(Hash.new(0)){ |f, w| f[w] += 1; f }.to_a.sort_by{ |x| -x[1] }[0,20].each{ |w, f| puts "%-30s%d" % [w, f] }

finish = Time.now

puts finish-start

# http://www.kinopoisk.ru/film/258687/ord/rating/status/good/perpage/200/#list
# http://www.kinopoisk.ru/film/262973/ord/rating/#list
# http://www.kinopoisk.ru/film/79338/ord/rating/#list
# http://www.kinopoisk.ru/film/329504/ord/rating/#list