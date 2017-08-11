defmodule Pokerwars.Hand.FlushTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  doctest Pokerwars.Hand

  test "High Card" do
    assert_score("2s 3h 5d 7s Js", :high_card)
  end

  test "Pair" do
    assert_score("As Ah 3d 4s 5h", :pair)
    assert_score("3d 10s 10h 4s 5h", :pair)
    assert_score("3d 4s 5h 10s 10h", :pair)
    assert_score("3d 7s 4h 7h 5h", :pair)
  end

  test "Two Pair" do
    assert_score("As Ah 3d 3s 5h", :two_pair)
    assert_score("3s 3h Ad As 5h", :two_pair)
    assert_score("4d 10s 10h 2s 4h", :two_pair)
    assert_score("3d 5s 5h 10s 10h", :two_pair)
    assert_score("3d 7s 4s 7h 3h", :two_pair)
  end

  test "Three of a kind" do
    assert_score("As Ah Ac 3d 4s", :three_of_a_kind)
    assert_score("3d 4s As Ah Ac", :three_of_a_kind)
    assert_score("7h 3d 7s 4s 7c", :three_of_a_kind)
  end

  test "Straight" do
    assert_score("As 2c 3s 4h 5d", :straight)
    assert_score("As 3s 2c 5d 4h", :straight)
    assert_score("As 10s Jc Kd Qh", :straight)
  end

  test "Full house" do
    assert_score("As Ah Ac 3d 3s", :full_house)
    assert_score("3s 3h 3c Ad As", :full_house)
    assert_score("3s Ad 3h As 3c", :full_house)
  end

  test "Flush" do
    assert_score("8h 2h Ah 9h 4h", :flush)
  end

  test "Four of a kind" do
    assert_score("As Ah Ac Ad 4s", :four_of_a_kind)
    assert_score("3d 5d 5s 5h 5c", :four_of_a_kind)
    assert_score("7h 7d 7s 4s 7c", :four_of_a_kind)
  end

  test "Straight Flush" do
    assert_score("As 2s 3s 4s 5s", :straight_flush)
    assert_score("Ah 3h 2h 5h 4h", :straight_flush)
    assert_score("Ad 10d 11d 13d 12d", :straight_flush)
  end

  defp compare_hand_score(left, right) do
    ranked_hands = [:straight_flush,
                    :four_of_a_kind,
                    :flush,
                    :full_house,
                    :straight,
                    :three_of_a_kind,
                    :two_pair,
                    :pair,
                    :high_card]
    leftIndex = Enum.find_index(ranked_hands, fn score -> score == left end)
    rightIndex = Enum.find_index(ranked_hands, fn score -> score == right end)

    #IO.puts("leftIndex: '#{leftIndex}'")
    #IO.puts("rightIndex: '#{rightIndex}'")

    leftIndex < rightIndex
  end

  test "Compare straight, flush returns false" do
    result = compare_hand_score(:straight, :flush)

    assert result == :false
  end

  test "Compare flush, straight, returns true" do
    result = compare_hand_score(:flush, :straight)

    assert result == :true
  end

  test "Sorting hand scores pair, straight, flush returns flush, straight, pair" do
    hand_scores = [:pair, :straight, :flush]

    result = Enum.sort(hand_scores, &compare_hand_score/2)
  
    assert result == [:flush, :straight, :pair]
  end

  test "Sorting cards and scores pair, straight, flush return flush, straight, pair" do
    hand_strings = ["8h 2h Ah 9h 4h", #flush
                    "As 2c 3s 4h 5d", #straight
                    "As Ah 3d 4s 5h"  #pair
    ]
    #hands = Enum.map(hand_strings, &[&1, parse_cards(&1)])
    hands_maps = Enum.map(hand_strings, &(%{string: &1, hand: parse_cards(&1)}))

    hand_scores_map = Enum.map(hands_maps, &(Map.put(&1, :score, Pokerwars.Hand.score(Map.get(&1, :hand)))))
    #hand_scores = Enum.map(hands, &(%{xstring: Enum.at(&1, 0),
    #  hand: Enum.at(&1, 1),
    #  score: Pokerwars.Hand.score(&1)
    #}))
    #IO.puts("hand scores: #{inspect(hand_scores)}")
    #IO.puts("hand scores: #{inspect(hand_scores_map)}")
    Enum.each(hand_scores_map, &(IO.puts("string #{inspect(Map.get(&1, :string))}\nhand #{inspect(Map.get(&1, :hand))}\nscore #{Map.get(&1, :score)}\n")))

#    flush_hand = %{cards: "8h 2h Ah 9h 4h", Pokerwars.Hand.score)
#    straight_hand("As 2c 3s 4h 5d", :straight)
#    assert_score("As Ah 3d 4s 5h", :pair)

    #TODO Sort by score field
    result = Enum.sort(hand_scores_map, &(compare_hand_score(Map.get(&1, :score))))

    IO.puts("Result: #{inspect(result)}")
  end
end
