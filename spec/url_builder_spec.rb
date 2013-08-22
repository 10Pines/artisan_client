require 'spec_helper'

describe ArtisanClient::UrlBuilder do

  let(:base_url) { 'https://artisan.com' }
  let(:project_key) { '1234' }
  let(:builder) { ArtisanClient::UrlBuilder.new(base_url, project_key) }

  it 'builds the url url api' do
    url = builder.iterations

    url.scheme.should == 'https'
    url.port.should == 443
    url.host.should == 'artisan.com'
    url.path.should == '/api/projects/iterations.json'
    url.query.should == 'key=1234'
  end

end