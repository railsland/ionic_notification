module IonicNotification
  class StatusService
    include HTTParty
    base_uri IonicNotification.ionic_api_url

    attr_accessor :body

    def initialize(message_uuid)
      @message_uuid = message_uuid
    end

    def check_status!
      self.class.get("/push/notifications/#{@message_uuid}", payload)
    end

    def check_messages_status!
      self.class.get("/push/notifications/#{@message_uuid}/messages", payload)
    end

    def payload
      options = {}
      options.
        merge!(headers: headers)
    end

    private

    def headers
      { 'Content-Type' => 'application/json', 'X-Ionic-Application-Id' => IonicNotification.ionic_application_id, 'Authorization' => IonicNotification.api_token_auth }
    end
  end
end
