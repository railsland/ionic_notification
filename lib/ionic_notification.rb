require 'rails'
require 'httparty'

module IonicNotification
  # Registered application if for the ionic platform
  mattr_accessor :ionic_application_id
  @@ionic_application_id = ""

  # Private api token for sending information
  mattr_accessor :ionic_application_api_token
  @@ionic_application_api_token = ""

  # Application name
  mattr_accessor :ionic_app_name
  @@ionic_app_name = Rails.application.class.parent_name

  # Is application in production
  mattr_accessor :ionic_app_in_production
  @@ionic_app_in_production = true

  # Send notification even if it has no message
  mattr_accessor :process_empty_messages
  @@process_empty_messages = false

  # Default message for notifications
  mattr_accessor :default_message
  @@default_message = "This was intended to be a beautiful notification. Unfortunately, you're not qualified to read it."

  # Default profile tag for notifications
  mattr_accessor :production_profile_tag
  mattr_accessor :development_profile_tag

  @@development_profile_tag = ""
  @@production_profile_tag = ""

  # Logging level
  mattr_accessor :log_level
  @@log_level = :debug

  # Array that stores latest X sent notifications
  mattr_accessor :latest_notifications
  @@latest_notifications = []

  # Array that stores latest X sent notifications
  mattr_accessor :notification_store_limit
  @@notification_store_limit = 3

  # API URL
  mattr_accessor :ionic_api_url
  @@ionic_api_url = "https://api.ionic.io"

  def self.setup
    yield self
  end

  def self.api_token_auth
    "Bearer " + ionic_application_api_token
  end

  def self.default_profile_tag
    if ionic_app_in_production
      production_profile_tag
    else
      development_profile_tag
    end
  end

  def self.store(notification)
    if latest_notifications.count >= notification_store_limit
      latest_notifications.shift
    end
    latest_notifications << notification
  end
end

require "ionic_notification/logger"
require "ionic_notification/push_service"
require "ionic_notification/status_service"
require "ionic_notification/notification"
require "ionic_notification/sent_notification"
require "ionic_notification/exceptions"
require "ionic_notification/concerns/ionic_notificable"
