# frozen_string_literal: true

module V1
  class Echo < Grape::API
    helpers do
      def endpoints
        Endpoint.all
      end

      def return_response(endpoint)
        status endpoint.response_code
        endpoint.headers.keys.each do |key|
          header key, headers[:key]
        end

        endpoint.body
      end
    end

    endpoints.each do |endpoint|
      resources endpoint.path do
        send(endpoint.verb) { return_response(endpoint) }
      end
    end
  end
end