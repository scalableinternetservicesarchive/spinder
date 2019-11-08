class PagesController < ApplicationController
    def home
    end
    
    def music
        @song = SongInfo.order('RANDOM()').first
    end

    def profile
        if current_user
            @email = current_user.email
            #@songs = ActiveRecord::Base.connection.execute("SELECT l.songs FROM songs l JOIN song_infos r ON songs.song_id = song_infos")
        else
        end
    end
end
