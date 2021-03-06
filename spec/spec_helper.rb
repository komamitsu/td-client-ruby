require 'rubygems'

begin
  require 'simplecov'
  SimpleCov.start
rescue LoadError
end

require 'rspec'
require 'webmock/rspec'

include WebMock::API

$LOAD_PATH << File.dirname(__FILE__)+"../lib"
require 'td-client'

include TreasureData

shared_context 'common helper' do
  let :account_id do
    1
  end

  let :headers do
    {'Accept' => '*/*', 'Accept-Encoding' => 'deflate, gzip', 'Date' => /.*/, 'User-Agent' => 'Ruby'}
  end

  def stub_api_request(method, path, opts = nil)
    scheme = 'http'
    with_opts = {:header => headers}
    if opts
      scheme = 'https' if opts[:ssl]
      with_opts[:query] = opts[:query] if opts[:query]
    end
    stub_request(method, "#{scheme}://api.treasure-data.com#{path}").with(with_opts)
  end

  def e(s)
    require 'cgi'
    CGI.escape(s.to_s)
  end
end
