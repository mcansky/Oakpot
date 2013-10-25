require_relative '../test_helper'

class TestOakableObject
  include Oakpot::Call
  attr_accessor :phone_number
end

class TestNonOakableObject
  include Oakpot::Call
end

describe "Configuration" do
  describe "setup" do
    before :each do
      Oakpot.setup do |config|
        config.twilio_api_token = "34524GVQSDCA2CT34CZDX2"
        config.twilio_api_sid = "3T34CZVQSDCA24524GCDX2"
      end
    end

    it 'should have an api token configured' do
      Oakpot.twilio_api_token.must_be :==, "34524GVQSDCA2CT34CZDX2"
    end

    it 'should have an api token configured' do
      Oakpot.twilio_api_sid.must_be :==, "3T34CZVQSDCA24524GCDX2"
    end
  end

  describe "Test Configuration" do
    before :each do
      Oakpot.setup do |config|
        config.twilio_api_token = "34524GVQSDCA2CT34CZDX2"
        config.twilio_api_sid = "3T34CZVQSDCA24524GCDX2"
      end
      Oakpot.load_and_set_settings!
    end

    it "Test constantes" do
      ['TWILIO_TOKEN','TWILIO_SID'].each do |constant|
        Kernel.const_defined?(constant).must_be :==, true
      end
    end

    it 'should have TWILIO_TOKEN constant' do
      TWILIO_TOKEN.must_be :==, "34524GVQSDCA2CT34CZDX2"
    end

    it 'should have TWILIO_SID constant' do
      TWILIO_SID.must_be :==, "3T34CZVQSDCA24524GCDX2"
    end
  end
end

describe TestOakableObject do
  subject { TestOakableObject.new }

  it "#is_oakpotable?" do
    subject.must_respond_to :is_oakpotable?
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
end
