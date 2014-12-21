module EventsJp
  class Connpass < EventsJp::EventObject
    ENDPOINT = 'http://connpass.com/api/v1/event/'.freeze
    DEFAULT_OPT = {order: 2, count: 100}.freeze

    class << self
      def get_events(keyword: nil, limit: nil)
        results, errors = [], []
        loop do
          tmp, err = access_wrapper do
            opt = merged_option(keyword, results, DEFAULT_OPT)
            convert_response(get(ENDPOINT, opt))
          end
          results += tmp
          errors << err
          break if finish_get?(results, tmp, limit)

          sleep(1)
        end

        return [results.uniq.compact.flatten, errors.compact.flatten]
      end

      def convert_response(json_str)
        e = Hashie::Mash.new(JSON.parse(json_str)).events
        e.map { |_| to_basic_hash(_) }
      end
    end
  end
end
