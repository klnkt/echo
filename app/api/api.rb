# frozen_string_literal: true

require 'grape'

module API
  class Root < Grape::API
    format :json

    mount V1::Endpoints

    Endpoint.all.each do |endpoint|
      send(endpoint.verb.downcase, endpoint.path) do
        status endpoint.response_code
        endpoint.headers.keys.each do |key|
          header key, headers[:key]
        end

        endpoint.body
      end
    end
  end
end