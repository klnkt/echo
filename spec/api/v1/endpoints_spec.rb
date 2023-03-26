# frozen_string_literal: true

require 'rails_helper'

describe V1::Endpoints, type: :request do
  let(:verb) { 'get' }
  let(:path) { '/foo/bar' }
  let(:api_response) { { code:, headers:, body: } }
  let(:code) { 200 }
  let(:headers) { { cookie: '1234' } }
  let(:body) { JSON.generate({ foo: 'bar' }) }

  describe 'GET /endpoints' do
    subject(:request) { get '/endpoints' }

    context 'when no endpoints exist' do
      it 'returns empty array' do
        request
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'when endpoints are present' do
      let!(:get_endpoint) { create :endpoint, verb: 'get' }
      let!(:post_endpoint) { create :endpoint, verb: 'post' }

      it 'returns all exisitng endpoints' do
        request
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to match_array(
          [get_endpoint.as_json, post_endpoint.as_json]
        )
      end
    end
  end

  describe 'POST /endpoints' do
    let(:request_params) { { verb:, path:, response: api_response } }
    subject(:request) { post '/endpoints', params: request_params }

    it 'request is success' do
      request

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)).to eq(Endpoint.first.as_json)
    end

    it 'creates the endpoint' do
      expect { request }.to change { Endpoint.all.count }.by(1)
    end

    context 'invalid request' do
      let!(:existing_endpoint) { create :endpoint, verb: 'get', path: '/foo/bar' }

      context 'when path is already taken' do
        it 'returns 422' do
          request
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)).to eq(
            {
              'error' => 'Invalid request',
              'details' => { 'path' => ['has already been taken'] }
            }
          )
        end
      end

      context 'when path is invalid' do
        let(:path) { 'foo bar' }

        it 'returns 422' do
          request
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)).to eq(
            {
              'error' => 'Invalid request',
              'details' => { 'path' => ['Path is invalid'] }
            }
          )
        end
      end
    end
  end

  describe 'PATCH /endpoints/:id' do
    let(:id) { endpoint.id }
    let(:request_params) { { verb:, path:, response: api_response } }
    subject(:request) { patch "/endpoints/#{id}", params: request_params }

    let!(:endpoint) { create :endpoint }
    let(:path) { '/bar/baz' }

    it 'updates endpoint data' do
      expect { request }.to change { endpoint.reload.path }.to path
    end

    it 'returns success' do
      request
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(endpoint.reload.as_json)
    end

    context 'when endpoint not found' do
      let(:id) { 0 }

      it 'returns 404 Not Found' do
        request
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)).to eq(
          { 'error' => 'Couldn\'t find Endpoint with \'id\'=0' }
        )
      end
    end

    context 'when invalid request' do
      let(:code) { 101 }

      it 'returns 422' do
        request
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)).to eq(
          {
            'error' => 'Invalid request',
            'details' => { 'response_code' => ['must be greater than 199'] }
          }
        )
      end
    end
  end

  describe 'DELETE /endpoints/:id' do
    let(:id) { endpoint.id }
    let(:request_params) { { verb:, path:, response: api_response } }
    subject(:request) { delete "/endpoints/#{id}" }

    let!(:endpoint) { create :endpoint }

    it 'deletes the endpoint' do
      expect { request }.to change { Endpoint.all.count }.by(-1)
    end

    it 'returns success' do
      request
      expect(response).to have_http_status(204)
    end

    context 'when endpoint not found' do
      let(:id) { 0 }

      it 'returns 404 Not Found' do
        request
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)).to eq(
          { 'error' => 'Couldn\'t find Endpoint with \'id\'=0' }
        )
      end
    end
  end
end
