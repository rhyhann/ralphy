require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require 'nokogiri'

module Ralphy
  VERSION = 0
end

DIR = File.expand_path %(#{File.dirname(__FILE__)}/ralphy)

require %(#{DIR}/xml_element)
require %(#{DIR}/wrapper)
