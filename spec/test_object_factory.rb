require 'rspec/mocks'

class TestObjectFactory

  def http_client
    HttpClientForTesting.new
  end

  def json_response_with_error_message a_message
    {'Error' => a_message}.to_json
  end

  def iterations
    [iteration]
  end

  def iteration
    ArtisanClient::Model::Iteration.new(10, 15, true, DateTime.new(2013, 8, 10), DateTime.new(2013, 8, 1), DateTime.new(2013, 8, 9), '1234', 1, DateTime.new(2013, 8, 2), DateTime.new(2013, 8, 3), 20)
  end

  def iterations_json
    [iteration_hash].to_json
  end

  def iteration_hash
    {'committed_points' => iteration.committed_points,
     'committed_points_at_completion' => iteration.committed_points_at_completion,
     'complete' => iteration.complete,
     'completed_at' => iteration.completed_at,
     'created_at' => iteration.created_at,
     'finish_date' => iteration.finish_date,
     'id' => iteration.id,
     'number' => iteration.number,
     'start_date' => iteration.start_date,
     'updated_at' => iteration.updated_at,
     'total_billed_points' => iteration.total_billed_points}
  end

  def url_builder
    ArtisanClient::UrlBuilder.new 'https://artisan.com', '1234'
  end

  def json_client_using an_http_client
    ArtisanClient::ArtisanApi.new an_http_client
  end

end