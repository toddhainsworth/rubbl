module Rubbl
  class ApiObject < DataObject
    def initialize(data, api_key, client = nil)
      @api_key = api_key
      @client = client || Rubbl::Client.new(@api_key)

      super(data)
    end

    def api_get(url)
      resp = @client.get(url)
      body = resp.body.to_s
      return nil if body.empty?
      JSON.parse(body)
    end
  end
end
