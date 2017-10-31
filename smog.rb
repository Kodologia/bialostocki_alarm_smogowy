require 'net/http'
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'sinatra'
require 'colorize'

uri = URI('http://www.wios.bialystok.pl/?go=airmiegod')
uploaded_page_data = Net::HTTP.get(uri) # => String
page_text= Nokogiri::HTML(uploaded_page_data)



value = page_text.css("//.centr//td").last

def style_color(x)
	if x.to_s > "1"
		'red'
	else
		'black'
	end
end

color = style_color(value)

get '/' do
	@value = value
	@color = color
	erb :index
end


