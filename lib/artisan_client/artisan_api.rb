require 'net/http'

module ArtisanClient

  class ArtisanApi

    def self.default
      self.new Net::HTTP
    end

    def initialize an_http_client
      @http_client = an_http_client
    end

    def fetch_results_from a_request_url
      json_response = send_request_to_artisan a_request_url

      json_object = parse_response json_response
      response = build_artisan_response_from json_object

      response.be_handled_by self
    end

    def handle_successful_response a_response
      a_response
    end

    def handle_failed_response a_response
      fail a_response.error_message
    end

    protected

    def send_request_to_artisan a_request_url
      @http_client.get a_request_url
    end

    def parse_response json_response
      JSON.parse json_response
    end

    def build_artisan_response_from json_object
      ArtisanClient::Response.to_handle json_object
    end

  end

end


