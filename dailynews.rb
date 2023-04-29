require 'nokogiri'
require 'open-uri'
require 'launchy'
require 'colorize'

def lemonde
  links = []
  titles = []
  descriptions = []
  doc = Nokogiri::HTML.parse(URI.open('https://www.lemonde.fr/'))

  puts "\n"
  puts 'Here are the 10 first articles of Le Monde'.blue
  puts "\n"

  # get links from articles
  doc.css('main a').first(10).each do |link|
    links << link['href']
  end

  # iterate through links
  links.each_with_index do |link, index|
    articlepage = Nokogiri::HTML.parse(URI.open("#{link}"))
    # find title
    title = articlepage.search('h1').text.strip
    titles << title
    # find description
    description = articlepage.search('.article__desc').text.strip
    descriptions << description
    puts "#{index + 1} - #{title.magenta}"
    puts description.to_s
    puts "\n"
  end

  # let user pick an index or exit
  puts 'Pick an index to open the article| next | break'.blue
  choice = gets.chomp

  if  choice == ''
    exit
  elsif choice == 'next'
    puts "\n"
    puts '--> On to the next one'
    puts "\n"
  else
    choice = choice.to_i - 1
    # open the article of the index he picks
    puts "\n"
    url = "#{links[choice]}"
    Launchy.open(url)
  end
  puts '-' * 50
end

def lesechos
  links = []
  titles = []
  descriptions = []
  doc = Nokogiri::HTML.parse(URI.open('https://www.lesechos.fr/'))

  puts "\n"
  puts 'Here are the 5 first articles of Les Echos'.blue
  puts "\n"

  # get links from articles
  doc.search('.gYtkct').first(5).each do |link|
    links << link['href']
  end

  # iterate through links
  links.each_with_index do |link, index|
    articlepage = Nokogiri::HTML.parse(URI.open("https://www.lesechos.fr#{link}"))
    # find title
    title = articlepage.search('h1').text.strip
    titles << title
    # find description
    description = articlepage.search('.fKyVcA').text.strip
    descriptions << description
    puts "#{index + 1} - #{title.magenta}"
    puts "#{description}"
    puts "\n"

  end

  # let user pick an index or exit
  puts 'Pick an index to open the article| next | break'.blue
  choice = gets.chomp

  if  choice == ''
    exit
  elsif choice == 'next'
    puts "\n"
    puts '--> On to the next one'
    puts "\n"
  else
    choice = choice.to_i - 1
    # open the article of the index he picks
    puts "\n"
    url = "www.lesechos.fr#{links[choice]}"
    Launchy.open(url)
  end
  puts '-' * 50
end

def economist
  links = []
  titles = []
  descriptions = []
  doc = Nokogiri::HTML.parse(URI.open('https://www.economist.com/'))

  puts "\n"
  puts 'Here are the first articles of The Economist'.blue
  puts "\n"

  # get links from articles
  doc.search('main section a').first(10).each do |link|
    links << link['href']
  end

  # iterate through links
  links.each_with_index do |link, index|
    articlepage = Nokogiri::HTML.parse(URI.open("https://www.economist.com#{link}"))
    # find title
    title = articlepage.search('h1').text.strip
    titles << title
    # find description
    description = articlepage.search('main article div section h2').text.strip
    descriptions << description
    puts "#{index + 1} - #{title.magenta}"
    puts "#{description}"
    puts "\n"
  end

  # let user pick an index or exit
  puts 'Pick an index to open the article| next | break'.blue
  choice = gets.chomp

  if  choice == ''
    exit
  elsif choice == 'next'
    puts "\n"
    puts '--> On to the next one'
    puts "\n"
  else
    choice = choice.to_i - 1
    # open the article of the index he picks
    puts "\n"
    url = "https://www.economist.com#{links[choice]}"
    Launchy.open(url)
  end
  puts '-' * 50
end

def ft
  links = []
  titles = []
  #descriptions = []
  doc = Nokogiri::HTML.parse(URI.open('https://www.ft.com/'))

  puts "\n"
  puts 'Here are the first articles of the Financial Times'.blue
  puts "\n"

  # get links from articles
  doc.search('main section a').first(5).each do |link|
    links << link['href']
  end

  links = links[1..links.length]

  # iterate through links
  links.each_with_index do |link, index|
    articlepage = Nokogiri::HTML.parse(URI.open("https://www.ft.com#{link}"))
    # find title
    title = articlepage.search('h1').text.strip
    titles << title
    # find description
    #description = articlepage.search('body div article figure figcaption').text.strip
    #descriptions << description
    puts "#{index + 1} - #{title.magenta}"
    #puts "#{description}"
    puts "\n"

  end

  # let user pick an index or exit
  puts 'Pick an index to open the article| next | break'.blue
  choice = gets.chomp

  if  choice == ''
    exit
  elsif choice == 'next'
    puts "\n"
    puts '--> On to the next one'
    puts "\n"
  else
    choice = choice.to_i - 1
    # open the article of the index he picks
    puts "\n"
    url = "https://www.ft.com#{links[choice]}"
    Launchy.open(url)
  end
  puts '-' * 50
end

newspapers = ['Le Monde', 'Les Echos', 'The Economist', 'The Financial Times']

loop do
  puts 'Here are the newspapers you can read:'.blue
  newspapers.each_with_index do |newspaper, index|
    puts "#{index + 1}. #{newspaper}".magenta
  end

  puts 'Enter the index of the newspaper you want to read (or exit):'.blue
  print '>'.blue
  input = gets.chomp.downcase
  break if input == ''

  input = input.to_i
  if input < 1 || input > newspapers.length
    puts "Invalid input. Please enter a number between 1 and #{newspapers.length} or exit.".blue
    next
  end

  puts "Reading #{newspapers[input - 1]}...".blue

  if input == 1
    lemonde
  elsif input == 2
    lesechos
  elsif input == 3
    economist
  elsif input == 4
    ft
  end
end
