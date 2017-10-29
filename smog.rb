require 'net/http'
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'sinatra'

uri = URI('http://www.wios.bialystok.pl/?go=airmiegod')
uploaded_page_data = Net::HTTP.get(uri) # => String
page_text= Nokogiri::HTML(uploaded_page_data)



puts page_text.css("//.centr//td").last

get '/' do
	"Stezenie czasteczek wynosi"
	
end


