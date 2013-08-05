require 'spec_helper'

describe ArtisanClient::FailedResponse do

  describe :with_results do

    it 'creates an instance with an error message' do
      response = ArtisanClient::FailedResponse.with_results 'Error' => 'foo'

      response.error_message.should == 'foo'
    end

    it 'cannot create an instance with nil results' do
      expect { ArtisanClient::FailedResponse.with_results nil }.
          to raise_error(RuntimeError, ArtisanClient::SuccessfulResponse::RESULTS_CANNOT_BE_NIL_MESSAGE)
    end

    it "'cannot create an instance from results that don't inform an error" do
      expect { ArtisanClient::FailedResponse.with_results 'Name' => 'John' }.
          to raise_error(RuntimeError, ArtisanClient::FailedResponse::INVALID_ERROR_RESULTS_MESSAGE)
    end

    it 'cannot create an instance from results types other than Hash' do
      expect { ArtisanClient::FailedResponse.with_results [] }.
          to raise_error(RuntimeError, ArtisanClient::FailedResponse::INVALID_ERROR_RESULTS_MESSAGE)
    end

  end

end