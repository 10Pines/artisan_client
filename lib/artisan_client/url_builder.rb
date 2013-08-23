module ArtisanClient

  class UrlBuilder

    def initialize a_base_url, a_project_key
      @base_url = a_base_url
      @project_key = a_project_key
    end

    def iterations
      URI "#{@base_url}/api/projects/iterations.json?key=#{@project_key}"
    end

    def total_billed_points_by_craftsman an_iteration_number
      URI "#{@base_url}/api/projects/iterations/#{an_iteration_number}/total_billed_points_by_craftsman.json?key=#{@project_key}"
      end

    def users
      URI "#{@base_url}/api/projects/users.json?key=#{@project_key}"
    end

  end

end