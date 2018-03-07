class LoginsController < ApplicationController
   
   def new
       if logged_in?
          flash[:success] = "Hello, #{current_user.chefname}, you are already logged in"
          redirect_back fallback_location: root_path
       end
   end
   
   def create
       chef = Chef.find_by(email: params[:email])
       if chef && chef.authenticate(params[:password])
           session[:chef_id] = chef.id
           flash[:success] = "Hello, #{chef.chefname}, you are logged in"
           redirect_to recipes_path
           
       else
           flash.now[:danger] = "You email address or password does not match"
           render 'new'
       end
               
   end
   
   def destroy
       session[:chef_id] = nil
       flash[:success] = "You are logged out, see you soon"
       redirect_to root_path

   end
    
end