require 'active_support/core_ext/module/attribute_accessors'
require "oakpot/version"

module Oakpot
  @@_ran_once = false

  mattr_accessor :twilio_api_token, :twilio_api_sid
  @@twilio_api_token, @@twilio_api_sid = nil, nil

  def self.setup
    yield self if @@_ran_once == false
    @@_ran_once = true
  end

  def self.load_and_set_settings!
    Kernel.send(:remove_const, 'TWILIO_TOKEN') if Kernel.const_defined?('TWILIO_TOKEN')
    Kernel.const_set('TWILIO_TOKEN', Oakpot.twilio_api_token)
    Kernel.send(:remove_const, 'TWILIO_SID') if Kernel.const_defined?('TWILIO_SID')
    Kernel.const_set('TWILIO_SID', Oakpot.twilio_api_sid)
  end

  def is_oakpotable?
    self.respond_to?(:phone_number)
  end

  module Call
    include Oakpot
  end
end
