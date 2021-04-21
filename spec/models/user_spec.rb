require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures presence of username' do            #test para evaluar que si un usuario no provee un usuario, éste no es creado
      user = User.new(password:'test123').save
      expect(user).to eq(false)
    end

    it 'ensures presence of password' do
      user = User.new(username:'test').save         #test para evaluar que si un usuario no provee una contraseña, éste no es creado
      expect(user).to eq(false)
    end

    it 'saves new user if password and user is created' do
      user = User.new(username:'test', password:'password').save        #Si se provee usuario y contraseña válidos, el usuario es creado
      expect(user).to eq(true)
    end

    it 'saves new user if password and user is created' do
      user = User.new(username:'', password:'password').save        #Si se provee usuario en blanco, el usuario no es creado(minimo 4 caracteres)
      expect(user).to eq(false)
    end

    it 'saves new user if password and user is created' do
      user = User.new(username:'test', password:'fas').save        #Si se provee contraseña en blanco, el usuario no es creado(minimo 4 caracteres)
      expect(user).to eq(false)
    end

  end
end
