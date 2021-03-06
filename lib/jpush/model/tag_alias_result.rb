require 'json'

module JPush
  class TagAliasResult
    attr_accessor :tags, :alias, :isok
    def initialize
      @isok=false
    end
    def fromResponse(wrapper)
      if wrapper.code != 200
        logger = Logger.new(STDOUT)
        logger.error('Error response from JPush server. Should review and fix it. ')
        logger.info('HTTP Status:' + wrapper.code.to_s)
        logger.info('Error Message:' + wrapper.error.to_s)
        raise JPush::ApiConnectionException.new(wrapper)
      end
      content = wrapper.getResponseContent
      hash = JSON.parse(content)
      @tags = hash['tags']
      @alias = hash['alias']
      @isok=true
      return self
    end
    
    def toJSON
      array={}
      array['tags'] = @tags
      array['alias'] = @alias
      return array
    end
  end
end