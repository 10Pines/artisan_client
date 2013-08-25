module ArtisanClient

  class UrlBuilder

    def initialize a_base_url, a_project_key
      @base_url = a_base_url
      @project_key = a_project_key
    end

    def iterations
      build_api_uri_for 'projects/iterations'
    end

    def total_billed_points_by_craftsman an_iteration_number
      build_api_uri_for "projects/iterations/#{an_iteration_number}/total_billed_points_by_craftsman"
    end

    def users
      build_api_uri_for 'projects/users'
    end

    def build_api_uri_for(a_path)
      URI "#{@base_url}/api/#{a_path}.json?key=#{@project_key}"
    end

  end

end