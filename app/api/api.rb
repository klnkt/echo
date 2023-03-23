# frozen_string_literal: true

require 'grape-swagger'

class API < Grape::API
    format :json
    prefix :api

    mount V1::Endpoints
    mount V1::Echo

    add_swagger_documentation
end