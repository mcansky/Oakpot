require_relative '../test_helper'

class TestOakableObject
  include Oakpot::Call
  attr_accessor :phone_number
end

class TestCustomOakableObject
  include Oakpot::Call
  attr_accessor :telephone
end

class TestNonOakableObject
  include Oakpot::Call
end

describe TestOakableObject do
  subject { TestOakableObject.new }

  it "#is_oakpotable?" do
    subject.must_respond_to :is_oakpotable?
  end

  it "is oakpotable" do
    subject.is_oakpotable?.must_be :==, true
  end

  it "is not connectable" do
    Oakpot.is_connectable?.must_be :==, false
  end

  it "should raise an exception when passing a call" do
    proc { subject.call("01010100100") }.must_raise NoMethodError
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

  it "should raise an exception when passing a call" do
    proc { subject.call("01010100100") }.must_raise NoMethodError
  end
end

describe TestOakableObject do
  before :each do
    path = File.expand_path File.dirname(__FILE__)
    twilio_config = YAML.load_file(path + '/../twilio_config.yml')
    Oakpot.setup do |config|
      config.twilio_api_token = twilio_config['TWILIO_API_TOKEN']
      config.twilio_api_sid = twilio_config['TWILIO_API_SID']
    end
    Oakpot.connect
  end

  subject { TestOakableObject.new }

  it "should return a hash when passing a call" do
    subject.call("01010100100").must_be_instance_of Hash
  end

  after :each do
    Oakpot.reset
  end
end
