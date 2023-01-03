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
        email: "new.user@email.com",
        password: "testingPass",
        password_confirmation: "testingPass"
      })
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
    end


  end
end
