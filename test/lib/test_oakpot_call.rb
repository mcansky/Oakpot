require_relative '../test_helper'

class TestOakableObject
  include Oakpot::Call
  attr_accessor :phone_number
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

  it "should not raise an exception when sending an sms" do
    subject.call("01010100100").must_be_instance_of Hash
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
    proc { subject.call("01010100100") }.must_raise NoMethodError
  end
end
