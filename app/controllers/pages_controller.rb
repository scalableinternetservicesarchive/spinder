class PagesController < ApplicationController
    def home
    end
    
    def music
    end

    def profile
        if current_user
            @email = current_user.email
        else
        end
    end
end
