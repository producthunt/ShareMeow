## ShareMeow
[![Build
Status](https://travis-ci.org/producthunt/ShareMeow.svg?branch=master)](https://travis-ci.org/producthunt/ShareMeow)
[![Code
Climate](https://codeclimate.com/github/producthunt/ShareMeow/badges/gpa.svg)](https://codeclimate.com/github/producthunt/ShareMeow)
[![Test
Coverage](https://codeclimate.com/github/producthunt/ShareMeow/badges/coverage.svg)](https://codeclimate.com/github/producthunt/ShareMeow/coverage)

ShareMeow is a Ruby microservice (ooh ahh) for creating super shareable, tweetable,
facebook-able images from your content :heart_eyes_cat:. You define a template (using HTML/CSS),
pass it some parameters, and it will generate an image to you.

It's what we use at [Product Hunt](https://www.producthunt.com) for making beautiful tweets like this:

<img width='375px' src="https://camo.githubusercontent.com/5bed0906f5c6bd07c843246f0baccd0e8fe03b2b/68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4356564445454f5641414164396a362e6a7067" alt="ShareMeow Preview Image" data-canonical-src="https://pbs.twimg.com/media/CVVDEEOVAAAd9j6.jpg" style="max-width:100%;">

## Features:
- Supports Emoji :100::heart_eyes_cat::sparkles:
- Custom fonts
- Cachable images (throw cloudflare infront of it & you're good to go)
- signed URLs via hmac digest

## Getting Started
For a quick introduction to how to use ShareMeow, take a [look
at this excellent screencast by GoRails](https://gorails.com/episodes/sharemeow).

[![ShareMeow
Screencast](http://img.youtube.com/vi/lcMuFj3EGb4/0.jpg)](https://gorails.com/episodes/sharemeow)

## The API

#### GET `/v1/:encoded_params/:encoded_hmac_digest/image.jpg`
This generates and returns a jpg.

Required params are determined by the image template you're using.

If you're using Ruby, you can use the [ShareMeow Ruby Client](https://github.com/producthunt/ShareMeowClient) for generating URLs easily.

If you'd rather not use the client. Here is an example of how to generate the URL in Ruby.

```Ruby
require 'base64'
require 'json'
require 'openssl'

json_params = { template: 'HelloWorld', message: 'Hello' }.to_json

encoded_params = Base64.urlsafe_encode64(json_params)
hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), 'your_secret_key', encoded_params)
hmac_digest = Base64.urlsafe_encode64([hmac].pack('H*'))

image_url = "https://your-share-meow.herokuapp.com/v1/#{ encoded_params }/#{ hmac_digest }/image.jpg"


# => "https://your-share-meow.herokuapp.com/v1/eyJ0ZW1wbGF0ZSI6IkhlbGxvV29ybGQiLCJtZXNzYWdlIjoiSGVsbG8ifQ==/-lgitNQmEs9NaiWyOCHeV137D80=/image.jpg"
```

## Deploy
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/producthunt/ShareMeow)


## Authentication :closed_lock_with_key:
ShareMeow uses URLs signed with an HMAC signature to ensure that only people with a secret key are able to generate URLs with your service.

It works like this:

Convert your parameters to JSON. Then [Base64 URL Safe encode](https://en.wikipedia.org/wiki/Base64#URL_applications) them. There are libraries available to do this in all major languages.

```Ruby
# Ruby
params = { template: 'HelloWorld', message: 'Hello, World' }
json_params = params.to_json

encoded_params = Base64.urlsafe_encode64(json_params)
```

Then create the HMAC signature from the encoded params and your secret key. Finish by packing and base64 encoding the signature (we do this to keep the URL shorter)

```Ruby
hmac_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), 'your_secret_key', encoded_params)
encoded_hmac = Base64.urlsafe_encode64([hmac_signature].pack('H*'))
```

When ShareMeow gets your request, it will recreate the HMAC signature using the encoded params/secret key. If it matches the signature you provided, it will generate the image. :star:

## Templates
Take a look here for example templates: https://github.com/producthunt/ShareMeow/tree/master/app/image_templates.

#### Custom Fonts
Here is example css using a font from [Google Fonts](https://www.google.com/fonts).

```css
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: local('Roboto Regular'), local('Roboto-Regular'), url(https://themes.googleusercontent.com/static/fonts/roboto/v10/2UX7WLTfW3W8TclTUvlFyQ.woff) format('woff');
}
```

#### Emoji :sparkles:
If you'd like to render emoji, you can use the `EmojiHelper` in your templates. It converts both unicode emoji and GitHub/Slack (`:smile:`) style emoji to images. Can do this by overriding `render_options`.

```Ruby
# images_templates/your_template.rb
require 'app/emoji_helper'

module ImageTemplates
  class YourTemplate < Base
    def render_options
      @options[:content] = EmojiHelper.emojify(@options[:content])
      super
    end
  end
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Start the server:
`$ puma`

## Contributing :heart:

Want to make this better? Great! :smile:

Bug reports and pull requests are welcome on GitHub at https://github.com/producthunt/ShareMeow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
