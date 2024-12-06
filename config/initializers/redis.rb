Redis.current = Redis.new(
  url: ENV['REDIS_URL'],  # URL should already include everything, including SSL and password
  ssl: true,
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
)