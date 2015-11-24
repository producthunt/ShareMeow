## ShareMeow
[![Build
Status](https://travis-ci.org/producthunt/ShareMeow.svg?branch=master)](https://travis-ci.org/producthunt/ShareMeow)

ShareMeow is a Ruby microservice for creating super shareable, tweetable,
facebook-able images from your content :heart_eyes_cat:. You define a template (using HTML/CSS),
pass it some parameters, and it will generate an image to you.

## Deploy
Info on how to deploy here.

## Authenticaion
Info on security/authentication here

## Templates
Info on how to create a new template here. :smile:

#### Custom Fonts
To use a custom font, you'll need to add it to the `fonts` directory and then reference it in your templates CSS. Truetype/ttf font files work best.

Here is example css using a font from [Google Fonts](https://www.google.com/fonts).
```css
@font-face {
  font-family: 'Source Sans Pro';
  src: url( '/fonts/SourceSansPro-Regular.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

Start the server:
`$ puma`

## Contributing :heart:

Want to make this better? Great! :smile:

Bug reports and pull requests are welcome on GitHub at https://github.com/producthunt/ShareMeow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
