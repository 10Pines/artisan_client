module ArtisanClient

  module Builders

    class TotalBilledPointsByCraftsmanBuilder

      def initialize response_results
        @data = response_results
      end

      def total_billed_points_by_craftsman
        response_data.inject({}) { |result, craftsman_points|
          craftsman = craftsman_points['craftsman']
          points = craftsman_points['points']
          result[craftsman] = points
          result
        }
      end

      def response_data
        @data['total_billed_points_by_craftsman']
      end

    end

  end

end