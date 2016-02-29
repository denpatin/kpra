require_relative 'kpra.rb'

# Set test parameters
mood = 'good'
films = [329504, 79338, 262973, 258687] # Empty, <10, standard, >200

def benchmark(id, mood, mode)
	get_info = "http://www.kinopoisk.ru/film/#{id}/ord/rating/status/#{mood}/perpage/10/"
	content = get_content(get_info)
	film_name = content.search('#headerFilm span[@itemprop="alternativeHeadline"]').first.text
	film_year = content.search('#infoTable table td div a').first.text.to_i
	puts "Benchmark started for #{film_name} (#{film_year}): #{mode.upcase} mode"
	puts
	unless content.search('.pagesFromTo').first.nil?
		count = content.search('.pagesFromTo').first.text[/\d+$/].to_i
		per_page = Array.new
		per_page = case count
		when 1..10
			[10]
		when 11..50
			[10,25,50]
		when 51..100
			[25,50,100]
		when 101..200
			[50,100,200]
		else
			[75,100,200]
			# [10,25,50,75,100,200].each { |p| if p < count then per_page.push p; next end; per_page.push p; break}
		end
		puts "In total #{count} reviews => benchmarking for #{per_page.join ', '} reviews per page"
		puts
		per_page.each do |perpage|
			start = Time.now
			get_reviews(id, mood, perpage, mode)
			finish = Time.now
			puts "#{finish-start}s for #{perpage} reviews per page"
			puts
		end
	else
		puts 'No reviews!'
		puts
	end
	puts "Benchmark finished"
end

# Main benchmark cycle
films.each do |film_id|
	benchmark(film_id, mood, 'quick')
	puts ".................."
	benchmark(film_id, mood, 'precise')
	puts "=================="
end

