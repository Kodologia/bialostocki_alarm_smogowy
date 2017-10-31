require 'net/http'
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'sinatra'
require "sinatra/reloader" if development?

# Zrobić nowy program, który będzie pobierał dane z WIOS o *:30 każdej godziny
# uruchamiać program co 30 minut za pomocą CRONa
# Przeczytać co to CRON i spróbować się pobawić
# crontab -e   służy do edycji crontaba
# zrobić takie coś /bin/bash touch /home/konrad/crontest
# CRON nie ważny

# TO jest ważne
# Program za pomocą marshall ma dopisywać do tablicy wartości PM2.5
# Z kolei strona smog.rb w sinatrze ma w get / odczytać ten plik, zdeserializować go i wyświetlić wszystkie wartości z niego
# Plik nazwać database.txt

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
