module ArtisanClient

  class Artisan

    def initialize(an_artisan_client, an_url_builder)
      @artisan_client = an_artisan_client
      @base_url = an_url_builder
    end

    def iterations
      iterations_url = @base_url.iterations

      response = @artisan_client.fetch_results_from iterations_url

      builder = Builders::IterationsBuilder.new response.results
      builder.iterations
    end

  end

end