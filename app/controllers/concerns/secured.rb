module Secured

    def authenticate_user!
        #Bearer xxxxxxx
        token_regex = /Bearer (\w+)/
        #leer header de auth
        headers = request.headers
        #verificar valido
        if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
            token = headers['Authorization'].match(token_regex)[1] #para tomar el valor del token solamente
            #verificar el token corresponde a un user
            if(Current.user = User.find_by_auth_token(token))
                return 
            end
        end

        render json: {error: 'Unauthorized'}, status: :unauthorized

    end

end