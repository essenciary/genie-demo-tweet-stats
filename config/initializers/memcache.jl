if Pkg.dir("Memcache") |> isdir
  using Memcache
  const MEMCACHECONN = MemcacheClient("localhost", 11211)
end
