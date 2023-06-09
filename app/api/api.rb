# frozen_string_literal: true

require 'grape'

module API
  # :no-doc
  class Root < Grape::API
    do_not_route_head!
    format :json

    mount V1::Endpoints

    Endpoint::VERBS.each do |verb|
      send(verb, '*wildcard') do
        response = WildcardService.new(params[:wildcard], verb).call
        error!("Endpoint with path /#{params[:wildcard]} does not exist", 404) unless response

        status(response.code)
        response.headers&.each_key { |key| header(key, response.headers[key]) }
        response.body
      end
    end
  end
end
