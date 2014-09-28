module EventsJp
  module Event
    class InvalidException < Exception; end

    def get_events(keyword: nil, curator_limit: nil)
      obj = [EventsJp::Atnd, EventsJp::Connpass, EventsJp::Doorkeeper, EventsJp::Zusaar]
      obj.map do |curator|
        next if curator == EventsJp::Doorkeeper and keyword
        curator.get_events(keyword: keyword, limit: curator_limit)
      end.flatten
    end
  end
end