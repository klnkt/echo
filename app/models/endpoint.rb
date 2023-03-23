# frozen_string_literal: true

class Endpoint < ApplicationRecord
  VERBS = %w[GET POST PATCH DELETE].freeze

  validates :path, uniqueness: { scope: [:verb] }
end
