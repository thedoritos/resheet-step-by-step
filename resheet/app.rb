module Resheet
  class App
    def self.call(env)
      [200, { 'Content-Type' => 'application/json' }, ['{ "message": "hello" }']]
    end
  end
end

