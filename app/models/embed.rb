class Embed
    include ActiveModel::Model
    include ActiveModel::Attributes
    include GlobalID::Identification
    include ActionText::Attachable
  
    attribute :id
  
    def self.find(id)
      new(id: id)
    end
  
    def source
      case
      when id.include?('youtube.com/embed')
        id
      when id.include?('youtube.com/watch')
        #https://www.youtube.com/watch?v=aqz-KE-bpKQ
        params = Rack::Utils.parse_query(URI(id).query)
        "https://www.youtube.com/embed/#{params['v']}"
      when id.include?('vimeo.com')
        param = id.split('/').last
        "https://player.vimeo.com/video/#{param}"
      else
        id
      end
    end
  end