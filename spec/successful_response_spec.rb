require 'spec_helper'

describe ArtisanClient::SuccessfulResponse do

  describe :with_results do

    it 'creates an instance with results' do
      results = [1, 2, 3]

      response = ArtisanClient::SuccessfulResponse.with_results results

      response.results.should == results
    end

    it 'cannot create an instance with nil results' do
      expect { ArtisanClient::SuccessfulResponse.with_results nil }.
          to raise_error(RuntimeError, ArtisanClient::SuccessfulResponse::RESULTS_CANNOT_BE_NIL_MESSAGE)
    end

  end

end