# Oakpot

This little module is aimed to save some time to add call and sms capacities to an existing application or module.

## Installation

Add this line to your application's Gemfile:

    gem 'oakpot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oakpot

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

This gem is tested using Ruby::MiniTest library if you want to add some functionnalities make sure to include tests for them.

## License

This gem is released under the MIT license.
