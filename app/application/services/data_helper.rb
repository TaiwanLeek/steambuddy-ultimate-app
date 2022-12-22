# frozen_string_literal: false

module SteamBuddy
  module Service
    # Given help method to operate player
    class DataHelper
      def self.friend_sort!(player, info_value)
        player.friend_list.sort! do |friend_a, friend_b|
          sorting_way(friend_a, friend_b, info_value)
        end
      end

      def self.sorting_way(friend_a, friend_b, info_value)
        # TODO
        case info_value
        when 'game_count'
          friend_b.game_count <=> friend_a.game_count
        when 'played_time'
          friend_b.total_played_time <=> friend_a.total_played_time
        when 'favorite_game'
          favorite_game_case(friend_a&.favorite_game&.played_time,
                             friend_b&.favorite_game&.played_time)
        else
          raise ArgumentError, 'Incorrect info_value!'
        end
      end

      def self.favorite_game_case(fav_played_time_a, fav_played_time_b)
        if (fav_played_time_a.is_a? Numeric) && (fav_played_time_b.is_a? Numeric)
          fav_played_time_b <=> fav_played_time_a
        else
          fav_played_time_a ? -1 : 1
        end
      end
    end
  end
end
