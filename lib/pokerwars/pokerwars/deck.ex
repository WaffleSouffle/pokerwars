defmodule Pokerwars.Deck do
  alias Pokerwars.Card

  @initial_deck  (for s <- [:h, :d, :c, :s], n <- 2..14, do: %Card{suit: s, rank: n})
  defstruct [cards: @initial_deck]

  def initial_deck do
    @initial_deck
  end
end
