require 'spec_helper'
require 'testing_http_client'

describe ArtisanClient::Client do

  let(:test_object_factory) { TestObjectFactory.new }
  let(:http_client) { Testing::HttpClient.new }
  let(:json_client) { JsonClient::Client.new http_client }
  let(:url_builder) { ArtisanClient::UrlBuilder.new 'http://foo.com', '1234' }
  let(:artisan_api) { ArtisanClient::Client.new json_client, url_builder }

  def simulate_iterations_response
    url = url_builder.iterations
    response = test_object_factory.iterations_json

    http_client.simulate_successful_response_for(url, response)
  end

  def simulate_total_billed_points_by_craftsman_response an_iteration_number
    url = url_builder.total_billed_points_by_craftsman an_iteration_number
    response = test_object_factory.total_billed_points_by_craftsman_json

    http_client.simulate_successful_response_for(url, response)
  end

  describe :iterations do

    before(:each) do
      simulate_iterations_response
    end

    it 'returns the project iterations' do
      iterations = artisan_api.iterations

      iterations.should have(1).item

      actual_iteration = iterations.first
      expected_iteration = test_object_factory.iterations.first

      actual_iteration.finish_date.should == expected_iteration.finish_date
      actual_iteration.id.should == expected_iteration.id
      actual_iteration.number.should == expected_iteration.number
      actual_iteration.start_date.should == expected_iteration.start_date
      actual_iteration.total_billed_points.should == expected_iteration.total_billed_points
    end

    describe :include? do

      it 'returns true for dates in the iteration' do
        iteration = artisan_api.iterations.first

        iteration.should include(iteration.start_date)
        iteration.should include(iteration.finish_date)
      end

      it 'returns dates for dates outside the iteration' do
        iteration = artisan_api.iterations.first

        iteration.should_not include(iteration.start_date - 1)
        iteration.should_not include(iteration.finish_date + 1)
      end

    end

  end

  describe :total_billed_points_by_craftsman do

    it 'returns total billed points in an iteration by craftsman' do
      iteration_number = 15
      simulate_total_billed_points_by_craftsman_response iteration_number

      result = artisan_api.total_billed_points_by_craftsman iteration_number

      result.should have(2).items
      result['John'].should == 9.3
      result['Mike'].should == 15.8
    end

  end

  describe :iterations_filtered_by_craftsman do

    before(:each) do
      simulate_iterations_response

      iteration = test_object_factory.iterations.first
      simulate_total_billed_points_by_craftsman_response iteration.number
    end

    it 'returns the project iterations with total_billed_points calculated for the selected craftsman only' do
      expected_iteration = test_object_factory.iterations.first

      iterations = artisan_api.iterations_filtered_by_craftsman(['Mike'])

      iterations.should have(1).item
      actual_iteration = iterations.first
      actual_iteration.finish_date.should == expected_iteration.finish_date
      actual_iteration.id.should == expected_iteration.id
      actual_iteration.number.should == expected_iteration.number
      actual_iteration.start_date.should == expected_iteration.start_date
      actual_iteration.total_billed_points.should == 15.8
    end


  end

  describe :users do

    def simulate_users_response
      url = url_builder.users
      response = test_object_factory.users_json

      http_client.simulate_successful_response_for url, response
    end

    it 'returns the names of the users that belongs to the project' do
      simulate_users_response

      result = artisan_api.users

      result.should have(2).items
      result.should include('John')
      result.should include('Mike')
    end

  end

end