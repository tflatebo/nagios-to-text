#!/usr/bin/env ruby 

require 'nokogiri'
require 'openssl'
require 'open-uri'
require 'date'
require 'digest/md5'
require 'pp'
require 'json'

class NagiosToText
  attr_accessor :title, :url, :text_content, :html_content, :image_uri

  def initialize(args, stdin)
    @url = ENV['NAG_URL']
  end

  # new parsing that pulls in their HTML formatting, but we lose the date parsing
  def run

    f = File.open("nagios.html")
    doc = Nokogiri::HTML(f) 
    f.close

    #doc = Nokogiri::HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE, http_basic_authentication: [ENV['NAG_USER'], ENV['NAG_PASS']]))

    rows = doc.xpath('//table/tr[@class="dataEven"]')
    details = rows.collect do |row|
      detail = {}
      [
        [:host, 'td[1]/a[2]/text()'],
        [:description, 'td[2]/text()'],
	[:check, 'td[6]/a/text()'],
        [:contact, 'td[15]/a/text()'],
      ].each do |name, xpath|
        detail[name] = row.at_xpath(xpath).to_s.strip
      end
      detail
    end
    puts JSON.pretty_generate(details)
  end
end

app = NagiosToText.new(ARGV, STDIN)
app.run

