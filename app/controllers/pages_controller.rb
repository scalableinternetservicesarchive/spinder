require 'set'

class PagesController < ApplicationController
    def home
    end
  
    # GET pages/music
    def music
  
      # # Get all songs from database that the user has liked
      # @songs = ActiveRecord::Base.connection.execute("" "
      #         SELECT r.name, r.song_id
      #         FROM songs l JOIN song_infos r ON r.song_id = l.song_id
      #         WHERE l.user_email = '#{params["user_email"]}';
      #     " "")
  
      # #get all songs that the user has disliked
      # dislikedSongs = ActiveRecord::Base.connection.execute("" "
      #         SELECT r.name, r.song_id
      #         FROM disliked_songs l JOIN song_infos r ON r.song_id = l.song_id
      #         WHERE l.user_email = '#{params["user_email"]}';
      #     " "")
      # #
      # # #filter out all disliked songs (really inefficient)
  
      # # Extract songs that user has already liked and disliked to just get new songs
      # filter_songs = []
      # for i in @songs
      #   filter_songs.push(i["song_id"])
      # end
  
      # for i in dislikedSongs
      #   filter_songs.push(i["song_id"])
      # end
  
  
      # # filter out the songs that we dont want to display
      # @song = SongInfo.where.not(song_id: filter_songs).order('RANDOM()').first
      all_songs = get_all_songs()
      liked_songs = get_liked_songs_only_id(params["user_email"])
      disliked_songs = get_disliked_songs()
  
      random_num = rand(1051)
      song = all_songs[random_num]

      while (liked_songs.include?(song["song_id"]) || disliked_songs.include?(song["song_id"])) do
        random_num = rand(1051)
        song = all_songs[random_num]
      end
      
      puts song['song_id']
      @song = song

    end
  
    # GET pages/profile
    def profile

        if current_user
            @email = params["user_email"]

            # Get all the songs that a user likes
            @songs = get_liked_songs()

            @matches = get_user_matches(@email)

            # # Run query that computes the matches that a user has, sorted from greatest to least
            # @matches = ActiveRecord::Base.connection.execute("""
            #     SELECT user_email, COUNT(*) AS cnt
            #     FROM songs
            #     WHERE (song_id IN ('#{song_id_arr.join("', '")}')) AND user_email != '#{params["user_email"]}'
            #     GROUP BY user_email
            #     ORDER BY cnt DESC;
            # """)
            # p @matches
        else
        end
    end
end