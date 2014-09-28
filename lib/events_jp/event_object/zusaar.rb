module EventsJp
  class Zusaar < EventsJp::EventObject
    ENDPOINT = 'http://www.zusaar.com/api/event/'.freeze
    DEFAULT_OPT = {count: 100}.freeze
    WAIT_SEC = 2

    class << self
      def get_events(keyword: nil, limit: nil)
        res = []
        loop do
          opt = merged_option(keyword, res, DEFAULT_OPT)
          tmp = convert_response(get(ENDPOINT, opt))
          res += tmp
          break if finish_get?(res, tmp, limit)
          sleep(WAIT_SEC)
        end
        res.uniq.flatten
      end

      def convert_response(json_str)
        e = Hashie::Mash.new(JSON.parse(json_str)).event
        e.map{ |_| to_basic_hash(_) }
      end
    end
  end
end
