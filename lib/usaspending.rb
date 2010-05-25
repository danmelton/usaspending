require 'open-uri'
require 'xmlsimple'
require 'net/http'


require "#{File.dirname(__FILE__)}/usaspending/base.rb"
Dir["#{File.dirname(__FILE__)}/usaspending/*.rb"].each { |source_file| require source_file }
