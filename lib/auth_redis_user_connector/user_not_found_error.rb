module AuthRedisUserConnector
  class UserNotFound < StandardError
    attr_accessor :id

    def initialize(id)
      @id = id
    end

    def message
      "#{self.class.name}: User with #@id not found"
    end
  end
end
