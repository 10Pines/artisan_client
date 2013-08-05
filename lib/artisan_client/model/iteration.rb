module ArtisanClient

  module Model

    class Iteration

      attr_reader :committed_points,
                  :committed_points_at_completion,
                  :complete,
                  :completed_at,
                  :created_at,
                  :finish_date,
                  :id,
                  :number,
                  :start_date,
                  :updated_at,
                  :total_billed_points

      def initialize committed_points, committed_points_at_completion, complete, completed_at, created_at, finish_date, id, number, start_date, updated_at, total_billed_points
        @committed_points = committed_points
        @committed_points_at_completion = committed_points_at_completion
        @complete = complete
        @completed_at = completed_at
        @created_at = created_at
        @finish_date = finish_date
        @id = id
        @number = number
        @start_date = start_date
        @updated_at = updated_at
        @total_billed_points = total_billed_points
      end

    end

  end

end