module EventsJp
  class EventObject
    class ImplementationException < Exception; end
    extend EventsJp::Connection

    def self.get_events(keyword: nil, limit: nil)
      results, errors = [], []
      loop do
        results, errors, has_response = access_wrapper(results, errors) do
          opt = merged_option(keyword, results, default_opt)
          convert_response(get(endpoint, opt))
        end
        break if finish_get?(results, has_response, limit)
        sleep(1)
      end

      return [results, errors]
    end

    private

    def self.access_wrapper(results, errors, &block)
      results << (tmp = block.call)
      has_response = (tmp.count >= 1)
      return [results.flatten.compact, errors, has_response]
    rescue => e
      errors << e.message
      has_response = false
      return [results, errors, has_response]
    end

    def self.service_name
      self.name.to_s.downcase.gsub(/^(.*::)/, '')
    end

    def self.merged_option(keyword, response, option)
      opt = option.dup
      opt.merge!({start: (response.count + 1)})
      keyword ? opt.merge!(keyword: keyword) : opt
    end

    def self.finish_get?(res, has_response, limit = nil)
      return true if limit.to_i > 0 && res.count >= limit
      return true unless has_response
      return false
    end

    def self.to_basic_hash(h)
      Hashie::Mash.new({ service:     service_name,
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
                         waiting:     h[:waiting] })
    end

    def self.parse_datetime(dt)
      dt ? DateTime.parse(dt) : nil
    end

    # インターフェース
    def self.endpoint
    end

    def self.default_opt
    end
  end
end