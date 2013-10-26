require_relative '../test_helper'

describe "Configuration" do
  it 'should have a custom attrbiutes defined' do
    Oakpot.phone_field.must_be :==, :phone_number
  end

  it 'should be connectable?' do
    Oakpot.is_connectable?.must_be :==, false
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

  describe 'test reset config' do
    before :each do
      Oakpot.setup do |config|
        config.twilio_api_token = "34524GVQSDCA2CT34CZDX2"
        config.twilio_api_sid = "3T34CZVQSDCA24524GCDX2"
        config.phone_attr = 'blob'
      end
      Oakpot.reset
    end

    it "should not have a custom phone attr" do
      Oakpot.phone_attr.must_be :==, nil
    end

    it "should not have any twilio config" do
      Oakpot.twilio_api_token.must_be :==, nil
      Oakpot.twilio_api_sid.must_be :==, nil
    end

    it "should return default phone field" do
      Oakpot.phone_field.must_be :==, :phone_number
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

  describe 'twilio connection' do
    before :each do
      path = File.expand_path File.dirname(__FILE__)
      twilio_config = YAML.load_file(path + '/../twilio_config.yml')
      Oakpot.setup do |config|
        config.twilio_api_token = twilio_config['TWILIO_API_TOKEN']
        config.twilio_api_sid = twilio_config['TWILIO_API_SID']
      end
    end

    it 'should be connectable?' do
      Oakpot.is_connectable?.must_be :==, true
    end

    describe 'on connect' do
      before do
        Oakpot.connect
      end

      it 'must have an open conenction' do
        Oakpot.connection.class.must_be :==, Twilio::REST::Client
      end
    end

    after :each do
      Oakpot.reset
    end
  end
end
