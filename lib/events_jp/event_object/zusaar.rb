module EventsJp
  class Zusaar < EventsJp::EventObject
    ENDPOINT = 'http://www.zusaar.com/api/event/'.freeze
    DEFAULT_OPT = {count: 100}.freeze

    def self.get_events(keyword: nil, limit: nil)
      results, errors = [], []
      loop do
        results, errors, has_response = access_wrapper(results, errors) do
          opt = merged_option(keyword, results, DEFAULT_OPT)
          convert_response(get(ENDPOINT, opt))
        end
        break if finish_get?(results, has_response, limit)
        sleep(1)
      end

      return [results, errors]
    end

    def self.convert_response(json_str)
      e = Hashie::Mash.new(JSON.parse(json_str)).event
      e.map{ |_| to_basic_hash(_) }
    end
  end
end
