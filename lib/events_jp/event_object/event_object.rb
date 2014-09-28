module EventsJp
  class EventObject
    class ImplementationException < Exception; end
    extend EventsJp::Connection

    class << self
      def class_name
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
            curator:     class_name,
            address:     h[:address],
            catch:       h[:catch],
            title:       h[:title],
            event_url:   h[:event_url],
            started_at:  h[:started_at],
            ended_at:    h[:ended_at],
            place:       h[:place],
            lon:         h[:lon],
            lat:         h[:lat],
            limit:       h[:limit],
            accepted:    h[:accepted],
            waiting:     h[:waiting]
        })
      end
    end
  end
end