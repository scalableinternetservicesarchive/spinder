class PagesController < ApplicationController
    def home
    end
    
    def music
        @song = SongInfo.order('RANDOM()').first
    end

    def profile
        if current_user
            @email = current_user.email
        else
        end
    end
end
