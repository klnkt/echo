# frozen_string_literal: true

require 'grape'

module API
  # :no-doc
  class Root < Grape::API
    format :json

    mount V1::Endpoints

    Endpoint::VERBS.each do |verb|
      send(verb, '*wildcard') do
        response = WildcardService.new(params[:wildcard], verb).call
        error!("Endpoint with path /#{params[:wildcard]} does not exist", 404) unless response

        status(response.code)
        response.headers.each { |k, v| header(k, v) }
        response.body
      end
    end
  end
end
