require "rubbl/version"
require "rubbl/data_object"
require "rubbl/client"
require "rubbl/workspace"

module Rubbl
  class Error < StandardError; end
  API_BASE_URL = "https://www.toggl.com/api/v8"
end
