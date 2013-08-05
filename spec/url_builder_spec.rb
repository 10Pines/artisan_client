require 'spec_helper'

describe ArtisanClient::UrlBuilder do

  let(:base_url) { 'https://artisan.com' }
  let(:project_key) { '1234' }
  let(:builder) { ArtisanClient::UrlBuilder.new(base_url, project_key) }

  it 'builds the iterations url api' do
    builder.iterations.should == "#{base_url}/api/projects/iterations.json?key=#{project_key}"
  end

end