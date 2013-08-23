require 'spec_helper'

describe ArtisanClient::UrlBuilder do

  let(:base_url) { 'https://artisan.com' }
  let(:project_key) { '1234' }
  let(:builder) { ArtisanClient::UrlBuilder.new(base_url, project_key) }

  it 'builds the iterations api url' do
    url = builder.iterations

    url.scheme.should == 'https'
    url.port.should == 443
    url.host.should == 'artisan.com'
    url.path.should == '/api/projects/iterations.json'
    url.query.should == 'key=1234'
  end

  it 'builds the total billed points by craftsman api url' do
    iteration_number = 15
    url = builder.total_billed_points_by_craftsman iteration_number

    url.scheme.should == 'https'
    url.port.should == 443
    url.host.should == 'artisan.com'
    url.path.should == "/api/projects/iterations/#{iteration_number}/total_billed_points_by_craftsman.json"
    url.query.should == 'key=1234'
  end

  it 'builds the users api url' do
    url = builder.users

    url.scheme.should == 'https'
    url.port.should == 443
    url.host.should == 'artisan.com'
    url.path.should == '/api/projects/users.json'
    url.query.should == 'key=1234'
  end

end