module SteamCircle
  class Friends
    def initialize(friends_data)
      @friends = friends_data
    end

    def list
      @friends
    end
  end
end