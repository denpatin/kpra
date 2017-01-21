# encoding: utf-8

require 'yandex_mystem'

reviews = %w(431148_bad.txt 431148_good.txt 431148_neutral.txt)
MAX = 10
reviews.each do |rev|
  corpus = []
  file = IO.read rev
  stemmed = YandexMystem::Simple.stem file
  stemmed.each { |ent| corpus << ent[1][0] unless ent[1][0].nil? }
  puts "For #{rev}"
  text = corpus.to_s.scan(/[А-Яа-яЁёA-Za-z-]{3,}/i)
  hash = text.inject(Hash.new(0)) { |f, w| f[w] += 1; f }
  arr = hash.to_a.sort_by { |x| -x[1] }
  arr[0, MAX].each { |w, f| puts format '%-20s%d', w, f }
  puts '---'
end
