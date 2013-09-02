module ArtisanClient

  module Model

    class Iteration

      attr_reader :id,
                  :number,
                  :total_billed_points

      def initialize id, number, duration, total_billed_points
        @id = id
        @number = number
        @duration = duration
        @total_billed_points = total_billed_points
      end

      def start_date
        @duration.begin
        end

      def finish_date
        @duration.end
      end

      def include? a_date
        @duration.include? a_date
      end

      def copy_with_new_total_billed_points points
        self.class.new id, number, @duration, points
      end

    end

  end

end