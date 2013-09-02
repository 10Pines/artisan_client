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
        Model::Iteration.new an_iteration_data['id'],
                             an_iteration_data['number'],
                             self.build_iteration_duration_from(an_iteration_data),
                             an_iteration_data['total_billed_points']
      end

      def build_iteration_duration_from an_iteration_data
        start_date = DateTime.parse an_iteration_data['start_date']
        finish_date = DateTime.parse an_iteration_data['finish_date']

        start_date..finish_date
      end

    end

  end

end