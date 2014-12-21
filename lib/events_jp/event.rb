module EventsJp
  module Event
    class InvalidException < Exception; end
    SERVICES = [EventsJp::Atnd, EventsJp::Connpass, EventsJp::Doorkeeper, EventsJp::Zusaar]

    def get_events(keyword: nil, service_limit: nil)
      results, errors = [], []

      Parallel.each(SERVICES, in_threads: SERVICES.count) do |service|
        next if service == EventsJp::Doorkeeper && keyword
        res, err = service.get_events(keyword: keyword, limit: service_limit)
        results << res
        errors << err
      end

      return [results.compact.flatten, errors.compact.flatten]
    end
  end
end
