defmodule BankTest do
  use ExUnit.Case
  doctest Bank

  test "grests the world" do
    assert Bank.hello() == :ok
  end
end