class PagesController < ApplicationController
    def home
    end

    def music
        @songs = ActiveRecord::Base.connection.execute("SELECT r.name, r.song_id FROM songs l JOIN song_infos r ON r.song_id = l.song_id WHERE l.user_email = '#{params["user_email"]}';")
        song_liked = []
        for i in @songs
            song_liked.push(i["song_id"])
        end
        puts "sup"
        puts song_liked
        @song = SongInfo.where(song_id: song_liked).order('RANDOM()').first
        puts @song
    end

    def profile
        if current_user
            @email = params["user_email"]
            @songs = ActiveRecord::Base.connection.execute("SELECT r.name, r.song_id FROM songs l JOIN song_infos r ON r.song_id = l.song_id WHERE l.user_email = '#{params["user_email"]}';")
            song_id_arr = []
            for i in @songs
                song_id_arr.push(i["song_id"])
            end
            puts song_id_arr.join(', ')
            query = "SELECT user_email, COUNT(*) as cnt FROM songs WHERE (song_id IN ('#{song_id_arr.join("', '")}')) and user_email != '#{params["user_email"]}' GROUP BY user_email ORDER BY cnt DESC;"
            @matches = ActiveRecord::Base.connection.execute(query)
        else
        end
    end
end
