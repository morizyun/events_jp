module EventsJp
  module Event
    class InvalidException < Exception; end

    def get_events(keyword: nil, service_limit: nil)
      obj = [EventsJp::Atnd, EventsJp::Connpass, EventsJp::Doorkeeper, EventsJp::Zusaar]
      obj.map do |service|
        next if service == EventsJp::Doorkeeper && keyword
        service.get_events(keyword: keyword, limit: service_limit)
      end.flatten.compact
    end
  end
end
