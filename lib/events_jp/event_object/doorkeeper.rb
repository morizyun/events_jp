module EventsJp
  class Doorkeeper < EventsJp::EventObject
    ENDPOINT = 'http://api.doorkeeper.jp/events'.freeze
    DEFAULT_OPT = {locale: 'ja', sort: 'starts_at'}.freeze

    class << self
      def get_events(keyword: nil, limit: nil)
        results, errors = [], []

        1.upto(1000) do |page|
          tmp, err = access_wrapper do
            opt = merged_option(page, DEFAULT_OPT)
            convert_response(get(ENDPOINT, opt))
          end
          results += tmp
          errors << err
          break if finish_get?(results, tmp, limit)
          sleep(1)
        end

        return [results.uniq.compact.flatten, errors.compact.flatten]
      end

      def merged_option(page, option)
        opt = option.dup
        opt.merge({page: page})
      end

      def convert_response(json_str)
        j = JSON.parse(json_str)
        j.map do |_|
          e = Hashie::Mash.new(_).event
          to_basic_hash(e)
        end
      end

      def to_basic_hash(h)
        Hashie::Mash.new({
             service:     service_name,
             address:     h[:address],
             title:       h[:title],
             catch:       nil,
             event_url:   h[:public_url],
             started_at:  parse_datetime(h[:starts_at]),
             ended_at:    parse_datetime(h[:ends_at]),
             place:       h[:venue_name],
             lon:         h[:long] ? h[:long].to_f : nil,
             lat:         h[:lat] ? h[:lat].to_f : nil,
             limit:       h[:ticket_limit],
             accepted:    h[:participants],
             waiting:     h[:waitlisted]
         })
      end
    end
  end
end
