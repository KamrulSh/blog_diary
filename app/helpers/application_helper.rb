module ApplicationHelper

    def gravatar_for(user)
        email_address = user.email.downcase
        hash = Digest::SHA256.hexdigest(email_address)
        size = 40
        params = URI.encode_www_form('s' => size)
        image_src = "https://www.gravatar.com/avatar/#{hash}?#{params}"
        image_tag(image_src, alt: user.username)
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end
    
end
