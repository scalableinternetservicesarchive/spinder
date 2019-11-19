class PagesController < ApplicationController
    def home
    end

    # GET pages/music
    def music

        # Get all songs from database
        @songs = ActiveRecord::Base.connection.execute("""
            SELECT r.name, r.song_id
            FROM songs l JOIN song_infos r ON r.song_id = l.song_id
            WHERE l.user_email = '#{params["user_email"]}';
        """)

        # Extract songs that user has already liked
        song_liked = []
        for i in @songs
            song_liked.push(i["song_id"])
        end

        # Only pick a random song that the user HASNT liked before
        @song = SongInfo.where.not(song_id: song_liked).order('RANDOM()').first
    end

    # GET pages/profile
    def profile

        if current_user
            @email = params["user_email"]

            # Get all the songs that a user likes
            @songs = ActiveRecord::Base.connection.execute("""
                SELECT r.name, r.song_id, r.artist
                FROM songs l JOIN song_infos r ON r.song_id = l.song_id
                WHERE l.user_email = '#{params["user_email"]}';
            """)

            # Extract only the song id's (song_ids required to find matches in next query)
            song_id_arr = []
            for i in @songs
                song_id_arr.push(i["song_id"])
            end

            # Run query that computes the matches that a user has, sorted from greatest to least
            @matches = ActiveRecord::Base.connection.execute("""
                SELECT user_email, COUNT(*) AS cnt
                FROM songs
                WHERE (song_id IN ('#{song_id_arr.join("', '")}')) AND user_email != '#{params["user_email"]}'
                GROUP BY user_email
                ORDER BY cnt DESC;
            """)
            p @matches
        else
        end
    end
end
