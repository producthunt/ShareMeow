require 'openssl'

# We need to limit who can generate images with ShareMeow.
#
# Requests to Share Meow require a 40 character hex encoded HMAC digest generated with
# a shared key (ENV var: SHARE_MEOW_KEY). If the digests match, the request is valid.

module ShareMeow
  module Authorization
    AUTH_DIGEST = OpenSSL::Digest.new('sha1'.freeze)
    AUTH_KEY = ENV.fetch('SHARE_MEOW_KEY'.freeze)

    def authorized?(digest, payload)
      hexdigest = OpenSSL::HMAC.hexdigest(AUTH_DIGEST, AUTH_KEY, payload)
      hexdigest == digest
    end
  end
end
