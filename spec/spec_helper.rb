# frozen_string_literal: true

require "bundler/setup"
require "rspec/matchers"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

require_relative "../lib/pubid-jis"
