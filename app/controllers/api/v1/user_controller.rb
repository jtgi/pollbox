class Api::V1::UserController < ApiController
	before_filter :authenticate_user!

	def show
		render :json=>{:id=>current_user.id, :email=>current_user.email, :first_name=>current_user.first_name, :last_name=>current_user.last_name}
	end
end
