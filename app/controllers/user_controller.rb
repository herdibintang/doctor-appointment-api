class UserController < ApplicationController
  skip_before_action :require_login, only: [:login]

  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  
  def index
    users = User.all

    render json: users
  end

  def create
    user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    
    if ! user.save
      return render json: {
        errors: user.errors
      }, status: 400
    end

    return render json: user
  end

  def show
    user = User.find(params[:id])

    render json: user
  end

  def update
    user = User.find(params[:id])

    if ! user.update(user_params)
      return render json: {
        errors: user.errors
      }, status: 400
    end

    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user_temp = user

    if ! user.destroy
      return render json: {
        errors: user.errors
      }, status: 400
    end

    render json: user_temp
  end

  def login
    user = User.find_by(email: params[:email])

    if ! user.try(:authenticate, params[:password])
      return render json: {
        message: "Email and/or password does not exist"
      }, status: 400
    end

    _token = SecureRandom.hex(10)

    token = Token.new(token: _token)

    if ! token.save
      return render json: {
        errors: token.errors
      }, status: 500
    end

    return render json: {
      token: _token
    }
  end

  def logout
    _token = request.headers["token"]
    
    token = Token.find_by(token: _token)

    if ! token.destroy
      return render json: {
        message: "error"
      }, status: 500
    end

    return render json: {
      message: "Logout successful"
    }
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
