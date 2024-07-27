defmodule FinixTest do
  use ExUnit.Case
  doctest Finix

  test "greets the world" do
    assert Finix.hello() == :world
  end
end
