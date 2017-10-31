require 'net/http'
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'sinatra'
require 'colorize'

uri = URI('http://www.wios.bialystok.pl/?go=airmiegod')
uploaded_page_data = Net::HTTP.get(uri) # => String
page_text= Nokogiri::HTML(uploaded_page_data)



value = (page_text.css("//.centr//td").last).to_s

def style_color(x)
	x = x.to_i
	if x > 10
		'blue'
	else
		'green'
	end
end

color = style_color(value)




get '/' do
	@value = value
	@color = color
	erb :index
end

binding.pry

