# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoint do
  describe 'validations' do
    subject { Endpoint.new }

    it { is_expected.to validate_presence_of(:verb) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:response_code) }
    it { is_expected.to validate_inclusion_of(:verb).in_array(Endpoint::VERBS) }
    it { is_expected.to validate_uniqueness_of(:path).scoped_to(:verb) }
    it { is_expected.to validate_numericality_of(:response_code).is_greater_than(199) }

    context 'valid path' do
      shared_examples_for 'path is invalid' do |path|
        it 'path is invalid' do
          endpoint = Endpoint.new(verb: 'get', path:, response_code: 200)
          expect(endpoint).not_to be_valid
        end
      end

      shared_examples_for 'path is valid' do |path|
        it 'path is invalid' do
          endpoint = Endpoint.new(verb: 'get', path:, response_code: 200)
          expect(endpoint).to be_valid
        end
      end

      include_examples 'path is valid', '/foo/bar'
      include_examples 'path is valid', '/id-1234/'

      include_examples 'path is invalid', 'foo/bar'
      include_examples 'path is invalid', '/'
      include_examples 'path is invalid', '/foo /bar'
      include_examples 'path is invalid', 'google.com/foo/bar'
      include_examples 'path is invalid', 'https://test.com/foo/bar'
    end
  end
end
