Dynamo.under_test(Tinymd.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Tinymd.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup_all do
    Dynamo.Loader.enable
    :ok
  end
end
