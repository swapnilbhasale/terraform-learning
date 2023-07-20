# Terraform Debugging

1. Terraform logging can be enabled by setting the TF_LOG env variable to any value to change the verbosity of the logs:
    1. TRACE
    2. DEBUG
    3. INFO
    4. WARN
    5. ERROR

2. TRACE is the most verbaose and it is the default if TF_LOG is set to something other than a log level name.

3. To persist logged output you can set TF_LOG_PATH in order to force the log to always be appended to a specific file when logging is enabled.