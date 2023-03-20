# frozen_string_literal: true

class Endpoint < ApplicationRecord
  VERBS = %w[
    GET,
    POST,
    PATCH,
    DELETE
].freeze

  def response
    { }
  end
end
