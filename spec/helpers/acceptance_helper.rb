# frozen_string_literal: true

ENV['RACK_ENV'] = 'app_test'

# require 'headless'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'
require 'watir'
require 'page-object'

require_relative 'spec_helper'
