require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "creates a user" do
      user = User.create!(name: "Sam", email: "sam@sam.com", password: "sam", password_confirmation: "sam")
      expect(user.valid?).to eql true
    end
    it "name validation fails when not present" do
      user = User.new(name: nil, email: "sam@sam.com", password: "sam", password_confirmation: "sam")
      expect(user.valid?).to eql false
      expect(user.errors.size).to eql 1
      expect(user.errors[:name]).to eql ["can't be blank"]
    end
    it "password validation fails when not present" do
      user = User.new(name: "Sam", email: "sam@sam.com", password: nil, password_confirmation: "sam")
      expect(user.valid?).to eql false
      expect(user.errors.size).to eql 1
      expect(user.errors[:password]).to eql ["can't be blank"]
    end
    it "email validation fails when not present" do
      user = User.new(name: "Sam", email: nil, password: "sam", password_confirmation: "sam")
      expect(user.valid?).to eql false
      expect(user.errors.size).to eql 1
      expect(user.errors[:email]).to eql ["can't be blank"]
    end
    it "fails when user email is not unique" do
      user1 = User.create!(name: "Sam", email: "TEST@TEST.com", password: "sam", password_confirmation: "sam")
      user = User.new(name: "Don", email: "test@test.COM", password: "don", password_confirmation: "don")
      expect(user.valid?).to eql false
      expect(user.errors.size).to eql 1
      expect(user.errors[:email]).to eql ["has already been taken"]
    end
  end

  describe ".password_length" do
    it "password validation fails when not password is too short" do
      user = User.new(name: "Sam", email: "sam@sam.com", password: "hi", password_confirmation: "hi")
      expect(user.password_length(user.password)).to eql false
    end
  end

  describe ".authenticate_with_credentials" do
    it "fails when login email does not match db email" do
     User.create!(name: "Sam", email: "TEST1@TEST.com", password: "sam", password_confirmation: "sam")
      email = "sam@gmail.com"
      password = "sam"
      expect(User.authenticate_with_credentials(email, password)).to eql false
    end
    it "fails when login password does not match db password" do
      User.create!(name: "Sam", email: "TEST2@TEST.com", password: "sam", password_confirmation: "sam")
      email = "TEST2@TEST.com"
      password = "wut"
      expect(User.authenticate_with_credentials(email, password)).to eql false
    end
    it "works when login email and password do match db email and password" do
      User.create!(name: "Sam", email: "TEST3@TEST.com", password: "sam", password_confirmation: "sam")
      email = "TEST3@TEST.com"
      password = "sam"
      expect(User.authenticate_with_credentials(email, password)).to eql true
    end
      it "works when login email includes spaces" do
      User.create!(name: "Sam", email: "example@domain.com", password: "sam", password_confirmation: "sam")
      email = " example@domain.com "
      password = "sam"
      expect(User.authenticate_with_credentials(email, password)).to eql true
    end
     it "works when login email has weird cases" do
      User.create!(name: "Sam", email: "eXample1@domain.COM", password: "sam", password_confirmation: "sam")
      email = "EXAMPLe1@DOMAIN.CoM"
      password = "sam"
      expect(User.authenticate_with_credentials(email, password)).to eql true
    end
  end
end