# frozen_string_literal: true

require 'rails_helper'

describe WildcardService do
  describe '#call' do
    let(:path) { 'foo/bar' } # grape passes path without first /
    let(:verb) { 'get' }

    subject { WildcardService.new(path, verb).call }

    context 'endpoint does not exist' do
      it { is_expected.to eq nil }
    end

    context 'endpoint exists' do
      let(:body) { 'baz' }
      let(:endpoint) do
        create :endpoint,
          verb:,
          path: "/#{path}",
          response_code: 201,
          headers: { 'Cookie' => '1234' },
          body:
      end

      before do
        endpoint.save!
        endpoint.reload
      end

      it 'returns response object' do
        expect(subject.class.name).to eq 'WildcardService::EchoResponse'
      end

      it 'returns response object with correct code' do
        expect(subject.code).to eq endpoint.reload.response_code
      end

      it 'returns response object with correct headers as hash' do
        expect(subject.headers).to eq endpoint.reload.headers
      end

      context 'return body as correct type' do
        context 'when string' do
          let(:body) { 'baz' }

          it 'returns string' do
            expect(subject.body).to eq endpoint.reload.body
          end
        end

        context 'when hash' do
          let(:body) { { 'baz' => 'qux' } }

          it 'returns hash' do
            expect(subject.body).to eq endpoint.reload.body
          end
        end
      end
    end
  end
end
