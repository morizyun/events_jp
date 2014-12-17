module EventsJp
  module Event
    class InvalidException < Exception; end
    SERVICES = [EventsJp::Atnd, EventsJp::Connpass, EventsJp::Doorkeeper, EventsJp::Zusaar]

    def get_events(keyword: nil, service_limit: nil)
      results = []

      Parallel.each(SERVICES, in_threads: SERVICES.count) do |service|
        next if service == EventsJp::Doorkeeper && keyword
        results << service.get_events(keyword: keyword, limit: service_limit)
      end

      results.compact.flatten
    end
  end
end
