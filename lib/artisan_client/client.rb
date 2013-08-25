require 'artisan_client/url_builder'
require 'artisan_client/builders/iterations_builder'
require 'artisan_client/builders/total_billed_points_by_craftsman_builder'

module ArtisanClient

  class Client

    def self.default artisan_url, project_key
      artisan_api = JsonClient.default
      url_builder = UrlBuilder.new artisan_url, project_key

      self.new artisan_api, url_builder
    end

    def initialize(an_artisan_client, an_url_builder)
      @artisan_client = an_artisan_client
      @base_url = an_url_builder
    end

    def iterations
      request_url = @base_url.iterations

      response = @artisan_client.fetch_results_from request_url

      builder = Builders::IterationsBuilder.new response.results
      builder.iterations
    end

    def total_billed_points_by_craftsman an_iteration_number
      request_url = @base_url.total_billed_points_by_craftsman an_iteration_number

      response = @artisan_client.fetch_results_from request_url

      builder = Builders::TotalBilledPointsByCraftsmanBuilder.new response.results
      builder.total_billed_points_by_craftsman
    end

    def users
      request_url = @base_url.users

      response = @artisan_client.fetch_results_from request_url

      response.results.collect{ |user_data| user_data['full_name'] }
    end

  end

end