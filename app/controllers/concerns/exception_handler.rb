# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      logger.error(e.message)
      render(json: { message: 'Record not found' }, status: :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      logger.error(e.message)
      render(json: { message: "Record invalid #{e.message}" }, status: :bad_request)
    end

    rescue_from ActiveRecord::NotNullViolation do |e|
      logger.error(e.message)
      render(json: { message: 'Mandatory parameters not provided' }, status: :bad_request)
    end

    rescue_from ActionController::ParameterMissing do |e|
      logger.error(e.message)
      render(json: { message: 'Some parameters are missing' }, status: :bad_request)
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      logger.error(e.message)
      render(json: { message: 'Record already exists' }, status: :bad_request)
    end

    rescue_from ActiveRecord::StatementInvalid do |e|
      logger.error(e.message)
      render(json: { message: 'Bad request' }, status: :bad_request)
    end
  end
end
