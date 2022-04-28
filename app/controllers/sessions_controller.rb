class SessionsController < ApplicationController

    # this handles logins, and creates a session cookie
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
            # logged in return
        else
            #not logged in return 
            render json: {error: 'Invalid username or password'}, status: :unauthorized
        end
    end

    # this handle log outs, and destroys a session cookie
    def destroy
        session.delete :user_id
        head :no_content
    end

end
