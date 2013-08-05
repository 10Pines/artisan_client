require 'spec_helper'

describe ArtisanClient::Artisan do

  let(:test_object_factory) { TestObjectFactory.new }
  let(:http_client) { test_object_factory.http_client }
  let(:json_client) { test_object_factory.json_client_using http_client }
  let(:url_builder) { test_object_factory.url_builder }
  let(:artisan_api) { ArtisanClient::Artisan.new json_client, url_builder }

  describe :iterations do

    it 'foo' do
      iterations_url = url_builder.iterations
      response = test_object_factory.iterations_json
      http_client.simulate_url_response(iterations_url, response)

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

end