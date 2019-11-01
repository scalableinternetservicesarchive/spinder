class PagesController < ApplicationController
    def show
        render template: "pages/about"
    end
    
    def to_music
        render template: "pages/music"
    end
end
