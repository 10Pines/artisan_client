require 'spec_helper'

def simulate_iterations_response
  iterations_url = url_builder.iterations
  response = test_object_factory.iterations_json
  http_client.simulate_url_response(iterations_url, response)
end

def simulate_total_billed_points_by_craftsman_response an_iteration_number
  url = url_builder.total_billed_points_by_craftsman an_iteration_number
  response = test_object_factory.total_billed_points_by_craftsman_json
  http_client.simulate_url_response(url, response)
end

def simulate_users_response
  url = url_builder.users
  response = test_object_factory.users_json
  http_client.simulate_url_response(url, response)
end

describe ArtisanClient::Artisan do

  let(:test_object_factory) { TestObjectFactory.new }
  let(:http_client) { test_object_factory.http_client }
  let(:json_client) { test_object_factory.json_client_using http_client }
  let(:url_builder) { test_object_factory.url_builder }
  let(:artisan_api) { ArtisanClient::Artisan.new json_client, url_builder }

  describe :iterations do

    it 'returns the project iterations' do
      simulate_iterations_response

      iterations = artisan_api.iterations

      iterations.should have(1).item

      actual_iteration = iterations.first
      expected_iteration = test_object_factory.iteration

      actual_iteration.committed_points.should == expected_iteration.committed_points
      actual_iteration.committed_points_at_completion.should == expected_iteration.committed_points_at_completion
      actual_iteration.complete.should == expected_iteration.complete
      actual_iteration.completed_at.should == expected_iteration.completed_at
      actual_iteration.created_at.should == expected_iteration.created_at
      actual_iteration.finish_date.should == expected_iteration.finish_date
      actual_iteration.id.should == expected_iteration.id
      actual_iteration.number.should == expected_iteration.number
      actual_iteration.start_date.should == expected_iteration.start_date
      actual_iteration.updated_at.should == expected_iteration.updated_at
      actual_iteration.total_billed_points.should == expected_iteration.total_billed_points
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

  describe :users do

    it 'returns the names of the users that belongs to the project' do
      simulate_users_response

      result = artisan_api.users

      result.should have(2).items
      result.should include('John')
      result.should include('Mike')
    end

  end

end