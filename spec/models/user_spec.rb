require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should throw no errors to create a user with all required" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryT@test.com", password: "password", password_confirmation: "password")
      @user.save
      expect(@user.errors.full_messages).to eq([])
    end
    it "should throw errors to create a user when missing" do
      @user = User.new(firstname: nil, lastname: nil, email: nil, password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Firstname can't be blank")
      expect(@user.errors.full_messages).to include("Lastname can't be blank")
      expect(@user.errors.full_messages).to include("Email can't be blank")
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "should throw errors when password and password_confirmation are not the same" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryT@test.com", password: "password", password_confirmation: "lastword")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should throw errors when password is too short" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryT@test.com", password: "pa", password_confirmation: "pa")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
    it "should throw errors when email already in use, even with uppercase/lowercase matches" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryT@test.com", password: "password", password_confirmation: "password")
      @user.save
      @user2 = User.new(firstname: "Terry", lastname: "Tester", email: "TERRYT@test.com", password: "password", password_confirmation: "password")
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it "provide user when authenticate with .authenticate_with_credentials" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryt@test.com", password: "password", password_confirmation: "password")
      @user.save
      @user_connecting = User.authenticate_with_credentials("terryt@test.com", "password")
      expect(@user_connecting).to eq(@user)
    end
    it "provide user when authenticate with .authenticate_with_credentials with spaces at start of auth" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryt@test.com", password: "password", password_confirmation: "password")
      @user.save
      @user_connecting = User.authenticate_with_credentials("   terryt@test.com  ", "password")
      expect(@user_connecting).to eq(@user)
    end
    it "provide user when authenticate with .authenticate_with_credentials mixed case email" do
      @user = User.new(firstname: "Terry", lastname: "Tester", email: "terryt@test.com", password: "password", password_confirmation: "password")
      @user.save
      @user_connecting = User.authenticate_with_credentials("TERRYT@TEST.CoM", "password")
      expect(@user_connecting).to eq(@user)
    end

  end


end
