require 'faraday'
require 'time'

class LeagueAPI
  attr_reader :url

  def initialize(host:, version:, api_url: 'api/lol/', region: 'na', endpoint: '')
    @host = host
    @url = build_url(host, api_url, region, version, endpoint)
    @client = Faraday.new(url) do |f|
      f.use Faraday::Adapter::NetHttp
    end
    @client.params = {api_key: ENV['API_KEY']}
  end

  def get(uri = '', params: {}, cache_key:)
    return nil if $redis.get('retry-after') && Time.now < Time.parse($redis.get('retry-after'))

    value = $redis.cache(cache_key) do
      response = client.get(uri) do |req|
        req.params.merge!(params)
      end

      if response.status == 429
        if response.headers['Retry-After']
          $redis.set('retry-after', Time.now + response.headers['Retry-After'].to_s)
        else
          sleep 1
          return get(uri, params: params, cache_key: cache_key)
        end
      end

      if response.headers['X-Rate-Limit-Count']
        limit_counts = response.headers['X-Rate-Limit-Count'].split(',')

        limit_counts.each do |count|
          requests, time = count.split(':')

          RateLimit.buffer_limit?(time, requests) do
            sleep 1
          end
        end
      end

      response.body
    end

    JSON.parse value, symbolize_names: true
  end

  private

  attr_reader :client, :host

  def build_url(*urls)
    urls.each_with_object('https://') do |sub_url, url|
      url.replace(concat_urls(url, sub_url))
    end
  end

  def concat_urls(url, sub_url)
    url = url.to_s
    sub_url = sub_url.to_s
    if url.slice(-1, 1) == '/' or sub_url.slice(0, 1) == '/'
      url + sub_url
    else
      "#{url}/#{sub_url}"
    end
  end
end