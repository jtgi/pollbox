class SessionsController < Devise::SessionsController
  def new
		super
		render :json=>{:id=>current_user.id,:id_test_data => 4, :first_name=>current_user.first_name, :last_name=>current_user.last_name}.to_json
  end
end