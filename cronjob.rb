#!/home/konrad/.rvm/rubies/ruby-2.4.0/bin/ruby

require 'net/http'
require 'nokogiri'

class Cronjob
  def initialize
    @sciezka = '/home/konrad/baza.txt'
  end

  def pobierz_pm25_z_wios
    uri = URI('http://www.wios.bialystok.pl/?go=airmiegod')
    uploaded_page_data = Net::HTTP.get(uri) # => String
    page_text= Nokogiri::HTML(uploaded_page_data)
    td_nodes = page_text.css("//.centr//td")
    td_nodes.last.text.to_i
  end

  def otworz_baze
    unless File.exist?(@sciezka)
      File.open(@sciezka, "w") do
        # Tworzy pusty plik i go zamyka od razu
      end
    end
    file = File.open(@sciezka, 'r')
  
    zawartosc_bazy = file.read

    if zawartosc_bazy.empty?
      @baza = []
    else
      @baza = Marshal.load(zawartosc_bazy)
    end
    file.close
    puts @baza.inspect
  end

  def dopisz_do_bazy(wartosc)
    @baza << [Time.now, wartosc]
  end

  def zapisz_baze
    File.open(@sciezka, 'w') do |f|
      f.write(Marshal.dump(@baza))
    end
  end

  def uruchom!
    otworz_baze

    pm25 = pobierz_pm25_z_wios

    dopisz_do_bazy(pm25)
    zapisz_baze
  end
end

Cronjob.new.uruchom!


