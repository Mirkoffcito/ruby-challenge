class UserRepresenter
    def initialize(current_user)
        @current_user = current_user
    end

    def as_json
        {
            Usuario: @current_user.username
        }
    end

end