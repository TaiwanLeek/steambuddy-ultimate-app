# frozen_string_literal: false

module SteamBuddy
  module Steam
    # Get player data from Api
    class PlayerMapper
      def initialize(steam_key, gateway_class = Steam::Api)
        @key = steam_key
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@key)
      end

      def find(remote_id)
        friend_list_data = @gateway.friend_list_data(remote_id)
        DataMapper.new(remote_id, @key, @gateway_class, friend_list_data).build_entity_with_friends
      end

      # Maintained a mapper that keep remote_id. However I don't think it is a good idea.
      class DataMapper
        def initialize(remote_id, key, gateway_class, friend_list_data = nil)
          @remote_id = remote_id
          @friend_list_data = friend_list_data
          @key = key
          @gateway_class = gateway_class
          @played_game_mapper = PlayedGameMapper.new(@key, @gateway_class)
        end

        def build_entity_with_friends
          SteamBuddy::Entity::Player.new(
            remote_id: @remote_id,
            username:,
            game_count:,
            full_friend_data: true,
            played_games:,
            friend_list:
          )
        end

        def build_entity
          SteamBuddy::Entity::Player.new(
            remote_id: @remote_id,
            username:,
            game_count:,
            full_friend_data: false,
            played_games:,
            friend_list: nil
          )
        end

        def game_count
          @played_game_mapper.find_game_count(@remote_id)
        end

        def played_games
          @played_game_mapper.find_games(@remote_id)
        end

        def username
          @gateway_class.new(@key).personaname(@remote_id)
        end

        def friend_list
          return unless @friend_list_data
          @friend_list_data.map do |friend_data|
            friend_steam_id = friend_data['steamid']
            DataMapper.new(friend_steam_id, @key, @gateway_class).build_entity
          end
        end
      end
    end
  end
end