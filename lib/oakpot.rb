require 'active_support/core_ext/module/attribute_accessors'
require "oakpot/version"
require 'twilio-ruby'

module Oakpot
  @@_ran_once = false

  mattr_accessor :twilio_api_token, :twilio_api_sid, :phone_attr, :connection
  @@twilio_api_token, @@twilio_api_sid, @@phone_attr, @@connection = nil, nil, nil, nil

  def self.setup
    yield self if @@_ran_once == false
    @@_ran_once = true
  end

  def self.connect
    @@connection = Twilio::REST::Client.new(@@twilio_api_sid,
      @@twilio_api_token)
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

  def number
    self.send(Oakpot.phone_field.to_sym)
  end

  def is_oakpotable?
    self.respond_to?(Oakpot.phone_field.to_sym)
  end

  module Call
    include Oakpot

    #
    # Create a call between the object number's and the number passed as
    # first param, the second param must an URL endpoint which outputs
    # valid TwiML.
    # The method then return a Twilio::REST::Call object
    def call(to_number, url = nil)
      raise NoMethodError unless self.is_oakpotable?
      raise NoMethodError unless Oakpot.is_connectable?
      raise ArgumentError, 'missing TwiML url' unless url
      @@connection.account.calls.create(from: number, to: to_number,
        url: url)
    end
  end

  module Message
    include Oakpot

    def boilerplate(hsh = {})
      raise NoMethodError unless self.is_oakpotable?
      raise NoMethodError unless Oakpot.is_connectable?
      @@connection.account.messages.create(from: hsh[:from], to: hsh[:to],
        body: hsh[:message])
    end

    def message(to_number, _message)
      boilerplate(from: number,
        to: to_number, message: _message)
    end

    def message_from(from_number, _message)
      boilerplate(from: from_number,
        to: number, message: _message)
    end
  end
end
