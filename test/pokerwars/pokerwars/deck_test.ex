defmodule Pokerwars.DeckTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  doctest Pokerwars.Deck
  
  test "Deck size" do
    assert length(%Pokerwars.Deck{}.cards) == 52
  end

  test "Initial Deck" do
    assert length(Pokerwars.Deck.initial_deck) == 52
  end

end
