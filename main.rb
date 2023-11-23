require 'net/http'
require 'colorize'

def http_prefix(url)
  unless url.start_with?('https://') || url.start_with?('http://')
    puts "Uyarı: URL, 'https://' veya 'http://' ile başlamalıdır.".colorize(:red)
    url = 'http://' + url
  end
  url
end

def print_separator(length)
  puts "\n#{'--' * length}\n"
end

def find_panel(url, path)
    combined_url = URI.join(url, path)
    response = Net::HTTP.get_response(combined_url)
    responseCode = response.code

    if responseCode == '200'
        puts "[+] Page Found: #{combined_url} #{responseCode}".colorize(:light_green)
    else
	puts "[-] Page Not Found: #{combined_url} #{responseCode}".colorize(:light_red)
  end
end

print "URL: ".colorize(:light_blue)
url = gets.chomp
url = http_prefix(url)

print "Wordlist: ".colorize(:light_blue)
wordlist = gets.chomp

File.foreach(wordlist) do |line|
    clean_line = line.strip

    unless clean_line.empty?
	puts "\n"
	find_panel(url, clean_line)
	
	length_url = url + clean_line
	print_separator(length_url.length)
    end
end
