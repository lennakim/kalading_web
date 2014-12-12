require 'restclient'

module ServerApi

  extend self

  # ServerApi.call "get", "city_capacity", { entry_id: "123", start_date: '1990-01-01', end_date: '2014-06-12' }

  # ServerApi.call "get", "auto_maintain_order"

  # ServerApi.call "post", "auto_maintain_order", { entry_id: "123", body: {...} }

  # ServerApi.call "post", "auto_maintain_price", { entry_id: "123", body: {...} }

  # ServerApi.call "get", "orders", { login_phone_num: 19999999999, client_id: 123, page: 1, per: 1000  }

  # ServerApi.call "put", "orders", { entry_id: "123", body: {...} }

  # on Exception: ServerApi.call("get", "auto_maintain_order"){ |error| [] }

  def call method, api_name, args = {}, &fail

    begin
      base_url = args[:entry_id] ? \
        "#{Settings.server_uri}/#{api_name}/#{args.delete(:entry_id)}.json" :
        "#{Settings.server_uri}/#{api_name}.json"
      url = append_query_string base_url, args.except(:body)

      Rails.logger.info '--- send api to url:'
      Rails.logger.info url

      result = method == "get" ? \
        RestClient.get(url, content_type: 'json') :
        RestClient.send(method, url, args[:body].to_json, content_type: 'json')

      JSON.parse result
    rescue Exception => e
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
