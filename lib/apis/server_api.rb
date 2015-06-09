require 'restclient'

module ServerApi
  extend self

  def call method, api_name, args = {}, &fail
    begin
      base_url = args[:entry_id] ? \
        "#{Settings.server_uri}/#{api_name}/#{args.delete(:entry_id)}.json" :
        "#{Settings.server_uri}/#{api_name}.json"
      url = append_query_string base_url, args.except(:body)

      Rails.logger.info '-' * 50
      Rails.logger.info url

      result = method == "get" ? \
        RestClient.get(url, content_type: 'json') :
        RestClient.send(method, url, args[:body].to_json, content_type: 'json')

      JSON.parse result
    rescue Exception => e
      Rails.logger.error("#{url}"

      fail.call e
    end
  end

  private

  def append_query_string uri, query_string_hash = {}
    uri = URI.parse(uri)

    query_string_arr = URI.decode_www_form(uri.query || '')

    query_string_hash.inject(query_string_arr) do|initial, e|
      initial << e if e.compact.length == 2
      initial
    end

    uri.query = URI.encode_www_form(query_string_arr)
    uri.to_s
  end

end
