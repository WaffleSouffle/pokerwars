defmodule Pokerwars.DeckTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  alias Pokerwars.{Deck, Card}
  doctest Pokerwars.Deck

  describe "Initial deck" do
    test "Deck size" do
      assert length(%Deck{}.cards) == 52
    end

    test "Initial Deck" do
      assert length(Deck.initial_deck) == 52
    end

    test "Initial deck first card is 2 of hearts" do
      assert Enum.at(Deck.initial_deck, 0) == %Card{suit: :hearts, rank: 2}
    end

    test "Initial deck last card is 14 of spades" do
      assert Enum.at(Deck.initial_deck, -1) == %Pokerwars.Card{suit: :spades, rank: 14}
      #assert Enum.at(Deck.initial_deck, -1) == Pokerwars.Card.parse("As")
    end
  end

  describe "Shuffle Deck" do
    test "Shuffled deck has same size as initial deck" do
      assert length(Deck.shuffled_deck) == length(Deck.initial_deck)
    end

    test "Deck shuffled with no-op shuffler is same as initial_deck" do
      assert Deck.shuffled_deck(shuffler: & &1) == Deck.initial_deck
    end
  end

end
