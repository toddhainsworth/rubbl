require 'http'

module Rubbl
  class Client
    def initialize(api_key)
      @api_key = api_key
    end

    def get(url, query = {})
      HTTP.basic_auth(auth_params).get(url, params: query)
    end

    def post(url, params = {})
      HTTP.basic_auth(auth_params).post(url, json: params)
    end

    def auth_params
      { user: @api_key, pass: 'api_token' }
    end
  end
end
