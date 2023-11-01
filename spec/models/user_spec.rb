require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'saves a user successfully with all four fields set' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user).to be_valid
    end

    it 'requires that password be set' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: nil,
        password_confirmation: 'password'
      )
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires that password_confirmation be set' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: nil
      )
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'requires that password and password_confirmation match' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'differentpassword'
      )
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires that email be set' do
      @user = User.new(
        name: 'name',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'requires that email be unique' do
      @user1 = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user1.save
      @user2 = User.new(
        name: 'name',
        email: 'NAME@COMPANY.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      @user2.save
      expect(@user2).not_to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires that password length is a minimum of 4 characters' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'pas',
        password_confirmation: 'pas'
      )
      @user.save
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'authenticates a user with a valid email and password' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@authenticated_user).to eq(@user)
    end

    it 'authenticates a user with a valid email with leading and trailing spaces' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials(
        '    name@company.com    ',
        @user.password
        )
      expect(@authenticated_user).to_not eq(@nil)
    end

    it 'authenticates a user with a valid email with inconsistent character case' do
      @user = User.new(
        name: 'name',
        email: 'name@company.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials('nAmE@cOmPaNy.CoM', @user.password)
      expect(@authenticated_user).to_not eq(@nil)
    end
  end
end
