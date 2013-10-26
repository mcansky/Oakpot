# Oakpot

This little module is aimed to save some time to add call and sms capacities to an existing application or module.

## Installation

Add this line to your application's Gemfile:

    gem 'oakpot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oakpot

## Intro

Oakpot is aimed to simplify the call and message triggers for your app by packing the wiring out of view. For messages it will be mostly enough, but for calls Oakpot does not handle the TwiML endpoints or the call object once the call is started. Your application will have to take care of those.

## Usage

To be able to use the Oakpot added methods the class you are going to extend must define an instance method or attribute called "phone_number".

Including the Oakpot::Message module in a class will add the capacity to trigger sms to the number returned by the "phone_number" method. A string will be necessary (the message itself).

Including the Oakpot::Call module in a class will add the capacity to trigger calls to the number returned by the "phone_number" method. A valid phone number will be necessary as parameter (yours or the one you want to be connected with the number provided by the object).

You will also need to do a bit of setup somewhere in your code. A Rails initializer will do nicely :

```ruby
  Oakpot.setup do |config|
    config.twilio_api_token = "<your_token>"
    config.twilio_api_sid = "<your_sid>"
  end
```

## Custom phone number field

To allow more flexibility you can use a custom phone number field and configure Oakpot to use it.

```ruby
  Oakpot.setup do |config|
    config.twilio_api_token = "<your_token>"
    config.twilio_api_sid = "<your_sid>"
    config.phone_attr = 'telephone'
  end
```

## Triggering a call

So, you have a User class including the Oakpot::Call module such as :

```ruby
class User
  include Oakpot::Call
  attr_accessor :phone_number
end
```

To be able to trigger calls from this user's number to another number you will need :
* a valid phone number for the user
* a valid phone number for the call receiver
* a valid TwiML url endpoint

If you are not familiar with TwiML you should checkout Twilio documentation : https://www.twilio.com/docs.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

This gem is tested using Ruby::MiniTest library if you want to add some functionnalities make sure to include tests for them.

## License

This gem is released under the MIT license.
