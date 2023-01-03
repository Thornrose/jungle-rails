require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      @user = User.new({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user.save!
      expect(@user.id).to be_present
    end

    it 'is not valid without a first name' do
      @user = User.create({
        first_name: nil, 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid without a last name' do
      @user = User.create({
        first_name: "New", 
        last_name: nil,
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid without a password' do
      @user = User.create({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: nil,
        password_confirmation: "testingPass"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid without a password confirmation' do
      @user = User.create({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: nil
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid unless the password confirmation is a match' do
      @user = User.create({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testing-Pass"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid if the password is not long enough' do
      @user = User.create({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "test",
        password_confirmation: "test"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid without an email' do
      @user = User.create({
        first_name: "New", 
        last_name: "User",
        email: nil,
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      expect(@user).not_to be_valid
    end

    it 'is not valid if the email is not unique' do
      @user1 = User.create({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user2 = User.create({
        first_name: "New", 
        last_name: "User",
        email: "NEW.USER@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return an instance of a user when given a valid email and password' do
      @user = User.new({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("new.user@email.com", "testingPass")
      expect(auth_user.first_name).to eq("New")
    end

    it 'should return false if given valid email with invalid password' do
      @user = User.new({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("new.user@email.com", "testing")
      expect(auth_user).not_to be
    end

    it 'should return false if given email is not found' do
      auth_user = User.authenticate_with_credentials("not-an-email@email.com", "testing")
      expect(auth_user).not_to be
    end

    it 'should return an instance of a user when given a valid email (with leading and trailing spaces) and password' do
      @user = User.new({
        first_name: "New", 
        last_name: "User",
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials(" new.user@email.com ", "testingPass")
      expect(auth_user.first_name).to eq("New")
    end

    it 'should return an instance of a user when given a valid email (with differing case) and password' do
      @user = User.new({
        first_name: "New", 
        last_name: "User",
        email: "new.USER@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      @user.save!
      auth_user = User.authenticate_with_credentials("NEW.user@email.com", "testingPass")
      expect(auth_user.first_name).to eq("New")
    end

  end

end
