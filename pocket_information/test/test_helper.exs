Code.require_file("support/test_stubs.exs", __DIR__)
Code.require_file("support/test_stubs_null_remover.exs", __DIR__)
ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter, ExUnitSonarqube])
ExUnit.start(exclude: [:skip])
