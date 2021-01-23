if Rails.env.development?
  REDIS_CLIENT = Redis.new(host: "localhost")
else
  REDIS_CLIENT = Redis.new(url: ENV.fetch("REDIS_URL"), driver: :ruby, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
end
