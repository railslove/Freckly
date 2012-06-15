module Faraday
  module Utils
    def build_query(params)
      params.build_query_params(:escape => true)
    end
  end
end