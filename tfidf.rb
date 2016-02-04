# encoding: utf-8

require 'similarity'

corpus = Corpus.new

doc1 = Document.new content: IO.read('positive.txt')
doc2 = Document.new content: IO.read('negative.txt')
doc3 = Document.new content: IO.read('neutral.txt')

[doc1, doc2, doc3].each { |doc| corpus << doc }

corpus.similar_documents(doc1).each do |doc, similarity|
  puts "Similarity between doc #{doc1.id} and doc #{doc.id} is #{similarity}"
end
corpus.similar_documents(doc2).each do |doc, similarity|
  puts "Similarity between doc #{doc1.id} and doc #{doc.id} is #{similarity}"
end
corpus.similar_documents(doc2).each do |doc, similarity|
  puts "Similarity between doc #{doc1.id} and doc #{doc.id} is #{similarity}"
end