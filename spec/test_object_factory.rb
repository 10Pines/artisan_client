require 'rspec/mocks'
require 'http_client_for_testing'
require 'artisan_client/model/iteration'

class TestObjectFactory

  def iteration
    ArtisanClient::Model::Iteration.new(10, 15, true, DateTime.new(2013, 8, 10), DateTime.new(2013, 8, 1), DateTime.new(2013, 8, 9), '1234', 1, DateTime.new(2013, 8, 2), DateTime.new(2013, 8, 3), 20)
  end

  def iterations
    [iteration]
  end

  def iterations_json
    [iteration_hash].to_json
  end

  def total_billed_points_by_craftsman_json
    '{"total_billed_points_by_craftsman":[{"craftsman":"John","points":9.3},{"craftsman":"Mike","points":15.8}]}'
  end

  def users_json
    '[{"email":"john@foo.com","full_name":"John","login":"john","uid":"1111"},{"email":"mike@bar.com","full_name":"Mike","login":"mike","uid":"2222"}]'
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


end