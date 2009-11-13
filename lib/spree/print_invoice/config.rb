module Spree
  module PrintInvoice
    # Singleton class to access the google base configuration object (GoogleBaseConfiguration.first by default) and it's preferences.
    #
    # Usage:
    #   Spree::GoogleBase::Config[:foo]                  # Returns the foo preference
    #   Spree::GoogleBase::Config[]                      # Returns a Hash with all the google base preferences
    #   Spree::GoogleBase::Config.instance               # Returns the configuration object (GoogleBaseConfiguration.first)
    #   Spree::GoogleBase::Config.set(preferences_hash)  # Set the google base preferences as especified in +preference_hash+
    class Config
      include Singleton
      include PreferenceAccess
    
      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          PrintInvoiceConfiguration.find_or_create_by_name("Default Print Invoice configuration")
        end
      end
    end
  end
end
