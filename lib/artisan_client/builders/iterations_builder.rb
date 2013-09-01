require 'artisan_client/model/iteration'

module ArtisanClient

  module Builders

    class IterationsBuilder

      def initialize iterations_data
        @iterations_data = iterations_data
      end

      def iterations
        @iterations_data.collect { |iteration_data| self.iteration_from_hash iteration_data }
      end

      def iteration_from_hash(an_iteration_data)
        Model::Iteration.new an_iteration_data['committed_points'],
                             an_iteration_data['committed_points_at_completion'].to_f,
                             an_iteration_data['complete'],
                             #TODO: to be refactored
                             (an_iteration_data['completed_at'].nil? ? nil : DateTime.parse(an_iteration_data['completed_at'])),
                             DateTime.parse(an_iteration_data['created_at']),
                             DateTime.parse(an_iteration_data['finish_date']),
                             an_iteration_data['id'],
                             an_iteration_data['number'],
                             DateTime.parse(an_iteration_data['start_date']),
                             DateTime.parse(an_iteration_data['updated_at']),
                             an_iteration_data['total_billed_points']
      end

    end

  end

end