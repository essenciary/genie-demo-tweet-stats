if Pkg.dir("Redis") |> isdir
  using Redis
  const REDISCONN = RedisConnection()
end
