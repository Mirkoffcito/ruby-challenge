class Api::V1::UserTokenController < Knock::AuthTokenController
    #This controller is meant specifically for signin, and it's different
    #from the users_controller.rb

    #this is necessary because rails changed in version 5.2
    skip_before_action :verify_authenticity_token, raise: false
end
