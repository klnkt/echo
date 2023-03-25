# frozen_string_literal: true

# Model for storing endpoints created by users
class Endpoint < ApplicationRecord
  VERBS = %w[get post patch delete].freeze

  validates :verb, inclusion: { in: VERBS }
  validates :verb, :path, :response_code, presence: true
  validates :path, uniqueness: { scope: [:verb] }
  validates :response_code, numericality: { greater_than: 199 }
  validate :path, :validate_path

  private

  def validate_path
    pattern = %r{^/[a-zA-Z0-9-]+(?:/[a-zA-Z0-9-]+)*/?$}
    return if path&.match?(pattern)

    errors.add(:path, 'Path is invalid')
  end
end
