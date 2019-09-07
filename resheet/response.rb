require 'json'

module Resheet
  class Response
    def initialize(payload = nil)
      @payload = payload
    end

    def json_header
      { 'Content-Type' => 'application/json' }
    end

    def json_body(payload)
      [JSON.generate(payload)]
    end

    def to_rack
      [200, json_header, json_body(@payload)]
    end
  end

  class ErrorResponse < Response
    def to_rack
      [404, {}, []]
    end
  end
end

