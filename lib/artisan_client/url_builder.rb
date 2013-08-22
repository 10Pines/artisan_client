module ArtisanClient

  class UrlBuilder

    def initialize a_base_url, a_project_key
      @base_url = a_base_url
      @project_key = a_project_key
    end

    def iterations
      URI "#{@base_url}/api/projects/iterations.json?key=#{@project_key}"
    end

  end

end