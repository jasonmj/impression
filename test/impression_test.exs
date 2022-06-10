defmodule ImpressionTest do
  use ExUnit.Case
  doctest Impression

  test "greets the world" do
    assert Impression.hello() == :world
  end
end
