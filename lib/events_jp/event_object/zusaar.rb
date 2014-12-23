module EventsJp
  class Zusaar < EventsJp::EventObject

    private

    def self.convert_response(json_str)
      e = Hashie::Mash.new(JSON.parse(json_str)).event
      e.map{ |_| to_basic_hash(_) }
    end

    def self.endpoint
      'http://www.zusaar.com/api/event/'
    end

    def self.default_opt
      {count: 100}
    end
  end
end
