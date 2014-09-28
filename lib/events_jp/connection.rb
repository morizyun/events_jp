require 'cgi'
require 'open-uri'
require 'json'
require 'hashie/mash'

module EventsJp
  module Connection
    def get(endpoint, opt = {})
      url = opt.empty? ? endpoint : "#{endpoint}?#{build_query(opt)}"
      open(url).read
    end

    private

    def build_query(options = {})
      options.to_a.map{|o| "#{o[0]}=#{CGI.escape(o[1].to_s)}" }.join('&')
    end
  end
end
