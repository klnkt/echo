# frozen_string_literal: true

# add a comment here
class WildcardService
  include ActiveModel::Model

  # Response object for wildcard endpoints
  class EchoResponse
    attr_accessor :code, :headers, :body
  end

  def initialize(path, verb)
    @path = path
    @verb = verb
  end

  def call
    endpoint = Endpoint.find_by(path: "/#{@path}", verb: @verb)
    return unless endpoint

    response = EchoResponse.new
    response.code = endpoint.response_code
    response.headers = endpoint.headers || {}
    response.body = to_json(endpoint.body)

    response
  end

  private

  def to_json(value)
    return unless value

    begin
      JSON.parse(value)
    rescue JSON::ParserError
      value
    end
  end
end
