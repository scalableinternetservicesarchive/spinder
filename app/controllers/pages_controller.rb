class PagesController < ApplicationController
    def show
        render template: "pages/about"
    end
end
