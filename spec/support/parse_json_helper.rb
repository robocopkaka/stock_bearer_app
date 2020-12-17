# frozen_string_literal: true

# helper to parse response body in tests
module ParseJsonHelper
  def json
    JSON.parse(response.body)
  end
end
