require_relative '../test_helper'

class TestOakableObject
  include Oakpot::Message
  attr_accessor :phone_number
end

class TestNonOakableObject
  include Oakpot::Message
end

class TestCustomOakableObject
  include Oakpot::Message
  attr_accessor :telephone
end

describe TestOakableObject do
  subject { TestOakableObject.new }

  it "#is_oakpotable?" do
    subject.must_respond_to :is_oakpotable?
  end

  it "#send" do
    subject.must_respond_to :send
  end

  it "is oakpotable" do
    subject.is_oakpotable?.must_be :==, true
  end
end

describe TestCustomOakableObject do
  subject { TestCustomOakableObject.new }

  it "is oakpotable" do
    subject.is_oakpotable?.must_be :==, false
  end
end

describe TestCustomOakableObject do
  subject { TestCustomOakableObject.new }

  before :each do
    Oakpot.setup do |config|
      config.phone_attr = 'telephone'
    end
  end

  after :each do
    Oakpot.reset
  end

  it "is oakpotable" do
    subject.is_oakpotable?.must_be :==, true
  end
end

describe TestNonOakableObject do
  subject { TestNonOakableObject.new }

  it "#is_oakpotable?" do
    subject.must_respond_to :is_oakpotable?
  end

  it "is oakpotable" do
    subject.is_oakpotable?.must_be :==, false
  end

  it "should raise an exception when sending an sms" do
    proc { subject.send("+0101010101010", "a string") }.must_raise NoMethodError
  end
end

describe TestOakableObject do
  before :each do
    path = File.expand_path File.dirname(__FILE__)
    twilio_config = YAML.load_file(path + '/../twilio_config.yml')
    @test_to = twilio_config['TEST_TO']
    @test_from = twilio_config['TEST_FROM']
    Oakpot.setup do |config|
      config.twilio_api_token = "14f3c6cefd8112cf133dc40c3f354492" ||twilio_config['TWILIO_API_TOKEN']
      config.twilio_api_sid = "ACe1792dd34ad37c145d0300b380b9a1bb" || twilio_config['TWILIO_API_SID']
    end
    Oakpot.connect
    subject.phone_number = @test_from
  end

  subject { TestOakableObject.new }

  it "should return a Twilio::REST::Message when sending a SMS" do
    skip 'waiting for Twilio-ruby release'
    message = 'Hello phone'
    @msg = subject.message(@test_to, message)
    @msg.must_be_instance_of Twilio::REST::Message
  end

  it "should return a Twilio::REST::Message when sending a SMS" do
    skip 'waiting for Twilio-ruby release'
    message = 'Hello phone'
    subject.phone_number = @test_to
    @msg = subject.message_from(@test_from, message)
    @msg.must_be_instance_of Twilio::REST::Message
  end

  after :each do
    Oakpot.reset
  end
end
