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

  it "should returning a hash when sending an sms" do
    subject.send("a string").must_be_instance_of Hash
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
    proc { subject.send("a string") }.must_raise NoMethodError
  end
end
