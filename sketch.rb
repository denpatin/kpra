# encoding: utf-8

require 'yandex_mystem'

reviews = %w[positive.txt negative.txt neutral.txt]
MAX = 10
reviews.each do |rev|
  corpus = []
  file = IO.read rev
  stemmed = YandexMystem::Simple.stem file
  stemmed.each {|ent| corpus << ent[1][0] unless ent[1][0].nil?}
  puts "For #{rev}"
  corpus.to_s.scan(/[А-Яа-яЁёA-Za-z-]{3,}/i).inject(Hash.new (0)){|f,w|f[w]+=1;f}.to_a.sort_by{|x|-x[1]}[0,MAX].each{|w,f|puts "%-20s%d"%[w,f]}
  puts '---'
end


# positives = []
# positive = IO.read 'positive.txt'
# positive_stemmed = YandexMystem::Simple.stem positive
# positive_stemmed.each {|ent| positives << ent[1][0] unless ent[1][0].nil?}

# positives.to_s.scan(/[А-Яа-яЁё]{7,}/i).inject(Hash.new (0)){|f,w|f[w]+=1;f}.to_a.sort_by{|x|-x[1]}[0,10].each{|w,f|puts "%-20s%d"%[w,f]}