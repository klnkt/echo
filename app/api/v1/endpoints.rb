# frozen_string_literal: true

module V1
  class Endpoints < Grape::API
    resources :endpoints do
      desc 'List existing endpoint',
        success: { message: 'Success' },
        failure: { code: 422, message: 'Invalid request' }
      get do
        Endpoints.all.as_json
      end

      route_param :id do
        desc 'Create an endpoint'
        params do
          requires :verb, type: String, values: Endpoint::VERBS, desc: 'HTTP method name'
          requires :path, type: String, desc: 'path part of URL' # add coerce
          requires :response, type: Hash do
            requires :code, type: Integer # coerce to be > 100 ?
            optional :headers, type: Hash do
              requires :header, type: String
              requires :value, type: String
            end
            optional :body, type: String
          end
        end
        post do
          endpoint = Endpoint.new(params)
          if endpoint.valid?
            return endpoint if endpoint.save
          end

          error!(422, 'Invalid request') # add more info here
        end
      end
    end
  end
end