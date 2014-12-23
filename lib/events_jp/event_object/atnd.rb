module EventsJp
  class Atnd < EventsJp::EventObject
    ENDPOINT = 'http://api.atnd.org/events/'.freeze
    DEFAULT_OPT = {format: 'json', count: 100}.freeze

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

      return [results.uniq.compact.flatten, errors.compact.flatten]
    end

    def self.convert_response(json_str)
      e = Hashie::Mash.new(JSON.parse(json_str)).events
      e.map { |_| to_basic_hash(_.event) }
    end
  end
end
