# frozen_string_literal: true

require 'rails_helper'

describe API, type: :request do
  let!(:endpoint) do
    create :endpoint,
      verb: 'post',
      path: '/test',
      response_code: 567,
      headers: { 'Custom-header' => 'test' },
      body: JSON.generate({ message: 'test' })
  end

  context 'when path does not exist' do
    subject(:request) { get '/test' }

    it 'returns 404 Not Found' do
      request
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Endpoint with path /test does not exist' })
    end
  end

  context 'when path exists' do
    subject(:request) { post '/test' }

    it 'returns correct response code' do
      request
      expect(response).to have_http_status(567)
    end

    it 'returns correct headers' do
      request
      expect(response.headers['Custom-header']).to eq 'test'
    end

    it 'returns correct body' do
      request
      expect(JSON.parse(response.body)).to eq({ 'message' => 'test' })
    end
  end
end
