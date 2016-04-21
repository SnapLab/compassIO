defmodule CompassIO.ParserTest do
  use ExUnit.Case
  doctest CompassIO

  alias CompassIO.DatFile.Parser
  alias CompassIO.Cave

  def cave do
    Parser.parse("test/support/Linea\ Dorada.dat")
  end

  test "it has a name" do
    assert cave.name == "Linea Dorada"
  end

  test "it has 6 surveys" do
    assert Enum.count(cave.surveys) == 6
  end

  test "it produces valid CompassIO.Cave params" do
    assert Cave.changeset(%Cave{}, cave).valid?
  end
end
