require 'spec_helper'

describe ArtisanClient::Response do

  describe :to_handle do

    context 'when the json object informs an error has occurred' do

      it 'foo' do
        response = ArtisanClient::Response.to_handle 'Error' => 'foo'

        response.should be_instance_of(ArtisanClient::FailedResponse)
        end

      it 'foo2' do
        response = ArtisanClient::Response.to_handle 'Name' => 'John'

        response.should be_instance_of(ArtisanClient::SuccessfulResponse)
      end

    end

  end

end