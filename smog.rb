require 'net/http'
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'sinatra'
require "sinatra/reloader" if development?

def pobierz_kolor_z_netu
	uri = URI('http://www.wios.bialystok.pl/?go=airmiegod')
	uploaded_page_data = Net::HTTP.get(uri) # => String
	page_text= Nokogiri::HTML(uploaded_page_data)
	page_text.css("//.centr//td").last.text
end

def style_color(x)
	x = x.to_i
	if x > 10
		'red'
	else
		'green'
	end
end

get '/' do
	@value = pobierz_kolor_z_netu()
	@color = style_color(@value)
	erb :index
end
