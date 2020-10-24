class ApplicationController < ActionController::API
  before_action :require_login
 
  private
    def require_login
      _token = request.headers[:token]

      if _token == nil
        return head 403
      end
      
      token = Token.find_by(token: _token)

      if token == nil
        return head 403
      end
    end
end
