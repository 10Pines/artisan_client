require 'spec_helper'

describe ArtisanClient::ArtisanApi do

  let(:test_object_factory) { TestObjectFactory.new }
  let(:request_url) { 'http://foo.com' }
  let(:http_client) { test_object_factory.http_client }
  let(:client) { ArtisanClient::ArtisanApi.new http_client }

  describe :fetch_results_from do

    context 'when the request is successful' do

      before(:each) do
        http_client.simulate_url_response(request_url, json_response)
      end

      context 'when the response is successful' do

        describe 'collection results' do

          context 'when there are no results' do

            let(:json_response) { [].to_json }

            it 'returns an SuccessResponse instance' do
              response = client.fetch_results_from request_url

              response.should be_instance_of(ArtisanClient::SuccessfulResponse)
            end

            it 'returns empty results' do
              response = client.fetch_results_from request_url

              response.results.should be_empty
            end

          end

          context 'when there is at least one result' do

            let(:json_response) { [1].to_json }

            it 'returns an SuccessResponse instance' do
              response = client.fetch_results_from request_url

              response.should be_instance_of(ArtisanClient::SuccessfulResponse)
            end

            it 'returns the results from the response' do
              response = client.fetch_results_from request_url

              response.results.should have(1).item
              response.results.first.should == 1
            end

          end

        end

        describe 'dictionary results' do

          context 'when there are no results' do

            let(:json_response) { {}.to_json }

            it 'returns an SuccessResponse instance' do
              response = client.fetch_results_from request_url

              response.should be_instance_of(ArtisanClient::SuccessfulResponse)
            end

            it 'returns empty results' do
              response = client.fetch_results_from request_url

              response.results.should be_empty
            end

          end

          context 'when there is at least one result' do

            let(:json_response) { {'Name' => 'John'}.to_json }

            it 'returns an SuccessResponse instance' do
              response = client.fetch_results_from request_url

              response.should be_instance_of(ArtisanClient::SuccessfulResponse)
            end

            it 'returns the results from the response' do
              response = client.fetch_results_from request_url

              response.results.should have(1).item
              response.results.should have_key('Name')
              response.results['Name'].should == 'John'
            end

          end

        end

      end

      context 'when the response fails' do

        let(:key_not_found_error_message) { 'Key not found' }
        let(:json_response) { test_object_factory.json_response_with_error_message key_not_found_error_message }

        it 'raises a RuntimeError with the error message from the response' do
          expect{ client.fetch_results_from request_url }.
              to raise_error(RuntimeError, key_not_found_error_message)
        end

      end

      context 'when the response body is an invalid json string' do

        let(:json_response) { 'foo' }

        it 'raises a JSON::ParserError error' do
          expect { client.fetch_results_from request_url }.
              to raise_error(JSON::ParserError)
        end

      end

    end

    context 'when the request fails' do

      context 'when an exception is raised' do

        let(:something_went_wrong_error) { RuntimeError.new 'oops... something went wrong!' }

        it 'does not catch the exception' do
          http_client.simulate_url_failure(request_url, something_went_wrong_error)

          expect { client.fetch_results_from request_url }.
              to raise_error(something_went_wrong_error)
        end

      end

    end

  end

end