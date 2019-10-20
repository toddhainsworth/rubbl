require 'http'

module Rubbl
  class Client
    def initialize(api_key)
      @api_key = api_key
    end

    def get(url, query = {})
      url = make_url(url)
      HTTP.basic_auth(auth_params).get(url, params: query)
    end

    def post(url, params = {})
      url = make_url(url)
      HTTP.basic_auth(auth_params).post(url, json: params)
    end

    def auth_params
      { user: @api_key, pass: 'api_token' }
    end

    def make_url(path)
      return path if path.start_with? "http"
      "#{Rubbl::API_BASE_URL}#{path}"
    end
  end
end
