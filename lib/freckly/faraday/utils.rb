module Faraday
  module Utils
    def build_query(params)
      params.to_param(:escape => true)
    end
  end
end