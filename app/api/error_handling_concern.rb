# frozen_string_literal: true

# Catch not found and validation records and return an API error with correct format
module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({ error: e.message }, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error!({ error: 'Invalid request', details: e.record.errors.messages }, 422)
    end
  end
end
