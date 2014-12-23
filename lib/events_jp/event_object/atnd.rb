module EventsJp
  class Atnd < EventsJp::EventObject

    private

    def self.convert_response(json_str)
      e = Hashie::Mash.new(JSON.parse(json_str)).events
      e.map { |_| to_basic_hash(_.event) }
    end

    def self.endpoint
      'http://api.atnd.org/events/'
    end

    def self.default_opt
      {format: 'json', count: 100}
    end
  end
end
