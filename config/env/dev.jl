using Configuration

export config

const config =  Settings(
                  output_length     = 100,
                  suppress_output   = false,
                  log_db            = true,
                  log_queries       = true,
                  log_requests      = false,
                  log_responses     = false,
                  log_router        = false,
                  log_formatted     = true,
                  log_level         = :debug,
                  log_cache         = false,
                  log_views         = false,
                  assets_path       = "/",
                  cache_duration    = 0,
                  flax_compile_templates = true,
                  websocket_server  = true,
                  session_auto_start     = false
                )
