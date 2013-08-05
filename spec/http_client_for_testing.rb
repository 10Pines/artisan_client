class HttpClientForTesting

  def initialize
    @fake_responses = {}
  end

  def get an_url
    @fake_responses[an_url].call
  end

  def simulate_url_failure an_url, an_error
    @fake_responses[an_url] = lambda{ fail an_error }
  end

  def simulate_url_response an_url, a_response
    @fake_responses[an_url] = lambda{ a_response }
  end

end