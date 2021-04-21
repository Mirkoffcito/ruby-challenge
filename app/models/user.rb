class User < ApplicationRecord
    has_secure_password
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates_length_of :username, minimum: 4, allow_blank: false

    validates_length_of :password, minimum: 4

    #definimos éste método porque por default, knock utiliza el email para la autenticación
    #nosotros optamos por no utilizar email con nuestros usuarios, por lo cual
    #configuramos para utilizar sólamente usuario y contraseña.
    def self.from_token_request request
        # Returns a valid user, `nil` or raise `Knock.not_found_exception_class_name`
        # e.g.
        username = request.params["auth"] && request.params["auth"]["username"]
        self.find_by(username: username)
    end


end