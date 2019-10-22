require 'json'

module Rubbl
  class Workspace < DataObject
    attr_accessor :data

    def initialize(data, api_key, client = nil)
      @api_key = api_key
      @client = client || Rubbl::Client.new(@api_key)

      super(data)
    end

    def self.all(api_key)
      client = Rubbl::Client.new(api_key)
      resp = client.get('/workspaces')
      body = resp.body.to_s
      return nil if body.empty?
      body = JSON.parse(body)

      body.map { |ws| Workspace.new(ws, api_key, client) }
    end

    def self.find(id, api_key)
      client = Rubbl::Client.new(api_key)
      resp = client.get("/workspaces/#{id}")
      body = resp.body.to_s
      return nil if body.empty?
      ws = JSON.parse(body)

      Workspace.new(ws['data'], api_key, client)
    end

    def users
    end

    def clients
    end

    def groups
    end

    def projects
    end

    def tasks
    end

    def tags
    end
  end
end
