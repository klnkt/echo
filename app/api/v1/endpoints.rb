# frozen_string_literal: true

module V1
  # CRUD API for endpoints
  class Endpoints < Grape::API
    include ErrorHandlingConcern

    helpers do
      def modified_params
        params[:response_code] = params[:response][:code]
        params[:headers] = params[:response][:headers]
        params[:body] = params[:response][:body]
        params.delete(:response)

        params
      end

      params :endpoint_params do
        requires :verb, type: String, values: Endpoint::VERBS, desc: 'HTTP method name'
        requires :path, type: String, desc: 'path part of URL'
        requires :response, type: Hash do
          requires :code, type: Integer, desc: 'HTTP response code or custom code. Must be greater than 199'
          optional :headers, type: Hash
          optional :body, type: String, desc: 'A string or a valid JSON'
        end
      end
    end

    resource :endpoints do
      desc 'List existing endpoints'
      get do
        Endpoint.all.as_json
      end

      desc 'Create an endpoint'
      params do
        use :endpoint_params
      end
      post do
        endpoint = Endpoint.new(modified_params)
        endpoint.save!
        endpoint
      end

      route_param :id do
        desc 'Update an endpoint'
        params do
          use :endpoint_params
        end
        patch do
          endpoint = Endpoint.find(params[:id])
          endpoint.update!(modified_params)
          endpoint.reload
        end

        desc 'Delete an endpoint'
        delete do
          Endpoint.find(params[:id]).destroy!
          status(204)
        end
      end
    end
  end
end
