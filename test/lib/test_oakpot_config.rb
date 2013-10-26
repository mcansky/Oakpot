require_relative '../test_helper'

describe "Configuration" do
  it 'should have a custom attrbiutes defined' do
    Oakpot.phone_field.must_be :==, :phone_number
  end

  describe "setup" do
    before :each do
      Oakpot.setup do |config|
        config.twilio_api_token = "34524GVQSDCA2CT34CZDX2"
        config.twilio_api_sid = "3T34CZVQSDCA24524GCDX2"
        config.phone_attr = 'blob'
      end
    end

    it 'should have an api token configured' do
      Oakpot.twilio_api_token.must_be :==, "34524GVQSDCA2CT34CZDX2"
    end

    it 'should have an api token configured' do
      Oakpot.twilio_api_sid.must_be :==, "3T34CZVQSDCA24524GCDX2"
    end

    it 'should have a custom attributes defined' do
      Oakpot.phone_attr.must_be :==, 'blob'
    end

    it 'should have access to it' do
      Oakpot.phone_field.must_be :==, 'blob'
    end
  end

  describe "Test Configuration" do
    before :each do
      Oakpot.setup do |config|
        config.twilio_api_token = "34524GVQSDCA2CT34CZDX2"
        config.twilio_api_sid = "3T34CZVQSDCA24524GCDX2"
        config.phone_attr = 'blob'
      end
      Oakpot.load_and_set_settings!
    end

    it "Test constants" do
      ['TWILIO_TOKEN','TWILIO_SID', 'OAKPOT_PHONE_ATTR'].each do |constant|
        Kernel.const_defined?(constant).must_be :==, true
      end
    end

    it 'should have TWILIO_TOKEN constant' do
      TWILIO_TOKEN.must_be :==, "34524GVQSDCA2CT34CZDX2"
    end

    it 'should have TWILIO_SID constant' do
      TWILIO_SID.must_be :==, "3T34CZVQSDCA24524GCDX2"
    end

    it 'should have OAKPOT_PHONE_ATTR constant' do
      OAKPOT_PHONE_ATTR.must_be :==, "blob"
    end
  end
end
