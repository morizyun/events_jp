module EventsJp
  class Doorkeeper < EventsJp::EventObject
    def self.get_events(keyword: nil, limit: nil)
      results, errors = [], []
      1.upto(1000) do |page|
        results, errors, has_response = access_wrapper(results, errors) do
          opt = merged_option(page, default_opt)
          convert_response(get(endpoint, opt))
        end
        break if finish_get?(results, has_response, limit)
        sleep(1)
      end

      return [results, errors]
    end

    private

    def self.merged_option(page, option)
      opt = option.dup
      opt.merge({page: page})
    end

    def self.convert_response(json_str)
      j = JSON.parse(json_str)
      j.map do |_|
        e = Hashie::Mash.new(_).event
        to_basic_hash(e)
      end
    end

    def self.to_basic_hash(h)
      Hashie::Mash.new({ service:     service_name,
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
                         waiting:     h[:waitlisted] })
    end

    def self.endpoint
      'http://api.doorkeeper.jp/events'
    end

    def self.default_opt
      {locale: 'ja', sort: 'starts_at'}
    end
  end
end
