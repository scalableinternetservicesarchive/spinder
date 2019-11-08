class PagesController < ApplicationController
    def home
    end
    
    def music
        @song = SongInfo.order('RANDOM()').first
    end

    def profile
        if current_user
            @email = current_user.email
            @songs = ActiveRecord::Base.connection.execute("SELECT r.name FROM songs l JOIN song_infos r ON r.song_id = l.song_id WHERE l.user_email = '#{current_user.email}';")
        else
        end
    end
end
