$:.unshift(File.expand_path(File.dirname(__FILE__)))

# Gems
require "faraday"
require "faraday_middleware"
require "multi_xml"

# Files
require "freckly/project"
require "freckly/entry"
require "freckly/faraday/parse_xml"
require "freckly/ext/enumerable"
require "freckly/faraday/utils"

module Freckly
  class << self
    attr_accessor :token, :subdomain

    def authed_get(path, options={})
      authed_connection.get do |request|
        request.url(path, options)
      end.body
    end

    def authed_connection
      headers = {
        :user_agent => "Freckly",
        "X-FreckleToken" => token
      }
      @connection ||= Faraday::Connection.new(:url => "https://#{subdomain}.letsfreckle.com",
                                              :headers => headers,
                                              :ssl => {:verify => false}) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseXml
        builder.use Faraday::Response::Mashify
      end
    end
  end
end