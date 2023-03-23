# frozen_string_literal: true

module V1
  class Echo < Grape::API
    # helpers do
    #   def endpoints
    #     Endpoint.all
    #   end

    #   def return_response(endpoint)
    #     status endpoint.response_code
    #     endpoint.headers.keys.each do |key|
    #       header key, headers[:key]
    #     end

    #     endpoint.body
    #   end
    # end

    # Endpoint.each do |endpoint|
    #     # send(endpoint.verb) { |endpoint| return_response(endpoint) }
    #     send(endpoint.verb.to_sym, endpoint.path) do
    #       'baz'
    #     end
    #   end
    # end

    # # resource(Endpoint.first.path) do
    # #   send(Endpoint.first.verb) { 'b1az' }
    # # end
  end
end