# frozen_string_literal: true

module ExternalApiService
  class UpdateThirdPartyEndpoints
    def call(customer)
      @customer = customer
      third_party_endpoints.each do |endpoint|
        send_request(:post, endpoint, @customer.to_json, header)
      end
    end

    private

    def send_request(method, url, body = '', headers = {})
      response = client.run_request(method, url, body, headers)
      response.to_hash.merge(success: response.success?)
    end

    def header
      {
        "Accept": '*/*',
        "Content-Type": 'application/json',
        "Authorization": generate_webhook_signature
      }
    end

    def client
      @client ||= Faraday.new
    end

    def third_party_endpoints
      endpoints = Rails.configuration.external_endpoints['third_party_endpoints']
      endpoints.values
    end

    def generate_webhook_signature
      secret_key = 'secret_key'
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret_key, @customer.to_json)
    end
  end
end
