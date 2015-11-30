Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(ENV.fetch('AWS_ACCESS_KEY'),
                                    ENV.fetch('AWS_SECRET_KEY'))
})
