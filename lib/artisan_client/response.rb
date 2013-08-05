module ArtisanClient

  class Response

    RESULTS_CANNOT_BE_NIL_MESSAGE = 'Results cannot be nil'

    def self.to_handle results
      return FailedResponse.with_results(results) if FailedResponse.can_handle?(results)
      SuccessfulResponse.with_results(results)
    end

    def be_handled_by a_response_handler
      fail 'subclass responsibility'
    end

    def self.with_results results
      validate_results results
      self.new results
    end

    def self.validate_results results
      fail RESULTS_CANNOT_BE_NIL_MESSAGE if results.nil?
    end

  end

  class SuccessfulResponse < Response

    attr_reader :results

    def initialize results
      @results = results
    end

    def be_handled_by a_response_handler
      a_response_handler.handle_successful_response self
    end

  end

  class FailedResponse < Response

    ARTISAN_RESPONSE_ERROR_KEY = 'Error'
    INVALID_ERROR_RESULTS_MESSAGE = 'Invalid error results'

    def self.validate_results results
      super results
      self.validate_is_hash results
      self.validate_has_error_key results
    end

    def self.validate_is_hash results
      self.raise_invalid_error_results unless results.is_a?(Hash)
    end

    def self.validate_has_error_key results
      self.raise_invalid_error_results unless results.has_key?(ARTISAN_RESPONSE_ERROR_KEY)
    end

    def self.raise_invalid_error_results
      fail INVALID_ERROR_RESULTS_MESSAGE
    end

    def self.can_handle? results
      results.is_a?(Hash) && results.has_key?(ARTISAN_RESPONSE_ERROR_KEY)
    end


    def initialize error_results
      @error_results = error_results
    end

    def be_handled_by a_response_handler
      a_response_handler.handle_failed_response self
    end

    def error_message
      @error_results[ARTISAN_RESPONSE_ERROR_KEY]
    end

  end

end