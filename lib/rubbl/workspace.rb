require 'json'

module Rubbl
  class Workspace < ApiObject
    attr_accessor :data

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
      return @users unless @users.nil?
      resp = api_get("/workspaces/#{id}/users")
      return [] if resp.nil?
      @users = body.map { |u| User.new(u, @api_key, @client) }
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
