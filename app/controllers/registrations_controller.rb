class RegistrationsController < ApplicationController
	def create
		Registration.new(params[:registration])
		room_id = params[:registration][:room_id]
		if Registration.save
			flash[:success] = "Registered Successfully"
			redirect_to {:controller=>"rooms", :action=>"show", :id=>room_id}
		else
			flash[:error] = "Registration Failed"
			redirect_to room_path
		end
	end

	def destroy
		Registration.where("user_id = ? AND room_id = ?", params[:registration][:user_id], params[:registration][:room_id]).destroy
		redirect_to room_path
	end
end
