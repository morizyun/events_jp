module EventsJp
  class Connpass < EventsJp::EventObject

    private

    def self.convert_response(json_str)
      e = Hashie::Mash.new(JSON.parse(json_str)).events
      e.map { |_| to_basic_hash(_) }
    end

    def self.endpoint
      'http://connpass.com/api/v1/event/'
    end

    def self.default_opt
      {order: 2, count: 100}
    end
  end
end
