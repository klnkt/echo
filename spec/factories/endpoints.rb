# frozen_string_literal: true

FactoryBot.define do
  factory :endpoint do
    verb { 'get' }
    path { '/foo/bar' }
    response_code { 200 }
  end
end
