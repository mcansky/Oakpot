require 'active_support/core_ext/module/attribute_accessors'
require "oakpot/version"

module Oakpot
  @@_ran_once = false

  mattr_accessor :twilio_api_token, :twilio_api_sid, :phone_attr
  @@twilio_api_token, @@twilio_api_sid, @@phone_attr = nil, nil, nil

  def self.setup
    yield self if @@_ran_once == false
    @@_ran_once = true
  end

  def self.reset
    return false unless @@_ran_once
    @@twilio_api_token, @@twilio_api_sid, @@phone_attr = nil, nil, nil
    @@_ran_once = false
  end

  def self.phone_field
    @@phone_attr || :phone_number
  end

  def self.is_connectable?
    if @@twilio_api_sid && @@twilio_api_token
      return true
    end
    false
  end

  def self.load_and_set_settings!
    Kernel.send(:remove_const, 'TWILIO_TOKEN') if Kernel.const_defined?('TWILIO_TOKEN')
    Kernel.const_set('TWILIO_TOKEN', Oakpot.twilio_api_token)
    Kernel.send(:remove_const, 'TWILIO_SID') if Kernel.const_defined?('TWILIO_SID')
    Kernel.const_set('TWILIO_SID', Oakpot.twilio_api_sid)
    Kernel.send(:remove_const, 'OAKPOT_PHONE_ATTR') if Kernel.const_defined?('OAKPOT_PHONE_ATTR')
    Kernel.const_set('OAKPOT_PHONE_ATTR', Oakpot.phone_attr)
  end

  def is_oakpotable?
    self.respond_to?(Oakpot.phone_field.to_sym)
  end

  module Call
    include Oakpot

    def call(number)
      raise NoMethodError unless self.is_oakpotable?
      {}
    end
  end

  module Message
    include Oakpot

    def send(number)
      raise NoMethodError unless self.is_oakpotable?
      {}
    end
  end
end
