class UsersController < ApplicationController
    def show
        render template: "users/registrations/new"
    end
end
