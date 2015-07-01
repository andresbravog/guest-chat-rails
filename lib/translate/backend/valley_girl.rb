module Translate::Backend::ValleyGirl
  API_URL = 'http://www.degraeve.com/cgi-bin/babel.cgi'
  
  def self.translate(message)
    response = RestClient.get API_URL, params: { d: 'valley', w: message }
    parser = Nokogiri::HTML(response.body)
    parser.xpath('//blockquote').map(&:content).first
  end
end
