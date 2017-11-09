defmodule Pokerwars.Deck do
  alias Pokerwars.Card

  @initial_deck  (for s <- [:hearts, :diamonds, :clubs, :spades], n <- 2..14, do: %Card{suit: s, rank: n})
  defstruct [cards: @initial_deck]

  def initial_deck do
    @initial_deck
  end

  def shuffled_deck(opts \\ []) do
    deck = Keyword.get(opts, :deck, initial_deck())
    shuffler = Keyword.get(opts, :shuffler, &Enum.shuffle/1)

    shuffler.(deck)
  end
end
