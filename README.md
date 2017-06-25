# Tweet Stats
Demo app for Genie, the highly productive Julia web framework. Presented at JuliaCon 2017.

### Instructions

1. clone the repo and install all the packages from REQUIRE
2. rename `config/secrets.example.jl` to `config/secrets.jl` and setup the required access tokens, per the comments in the file.
3. follow the instructions from [Genie's README](https://github.com/essenciary/Genie.jl) to start an interactive Genie REPL.
4. once in the Genie REPL, start the web server: `genie> AppServer.startup()`
5. after setting app the `config/secrets.jl` file and the connectivity to the Twitter and Aylien APIs, start the background task: `genie> Toolbox.run_task("ImportTweets")`
6. once the web server is running, go to `http://localhost:8000`
