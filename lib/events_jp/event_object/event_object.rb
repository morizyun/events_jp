module EventsJp
  class EventObject
    class ImplementationException < Exception; end
    extend EventsJp::Connection

    class << self
      def access_wrapper(&block)
        return [block.call, nil]
      rescue => e
        return [[], e.message]
      end

      def service_name
        self.name.to_s.downcase.gsub(/^(.*::)/, '')
      end

      def merged_option(keyword, response, option)
        opt = option.dup
        opt.merge!({start: (response.count + 1)})
        keyword ? opt.merge!(keyword: keyword) : opt
      end

      def finish_get?(res, current, limit = nil)
        return true if limit.to_i > 0 && res.count >= limit
        return true if current.count == 0
        return false
      end

      def to_basic_hash(h)
        Hashie::Mash.new({
            service:     service_name,
            address:     h[:address],
            catch:       h[:catch],
            title:       h[:title],
            event_url:   h[:event_url],
            started_at:  parse_datetime(h[:started_at]),
            ended_at:    parse_datetime(h[:ended_at]),
            place:       h[:place],
            lon:         h[:lon].to_f,
            lat:         h[:lat].to_f,
            limit:       h[:limit],
            accepted:    h[:accepted],
            waiting:     h[:waiting]
        })
      end

      def parse_datetime(dt)
        dt ? DateTime.parse(dt) : nil
      end
    end
  end
end