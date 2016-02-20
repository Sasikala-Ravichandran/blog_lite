require 'rails_helper'

RSpec.describe User, :type => :model do
  
  before :each do
    @user = User.new(first_name: "Maxy", last_name: "Doe",
                      email: "maxydoe@example.com", password: "password",
                      about: "I am a doctor who is practising internal medicine",
                      url: "https://www.maxydr.com")
  end
  
  it "requires first name" do
    @user.first_name = " "
    expect(@user).not_to be_valid
    expect(@user.errors.any?).to be_truthy
  end

  it "requires last name" do
    @user.last_name = " "
    expect(@user).not_to be_valid
    expect(@user.errors.any?).to be_truthy
  end

  it "requires valid email format" do
    valid_emails = %w[user@ex.com USER@example.com
                      User_Foo@bar.org U123@Example.gov]
    valid_emails.each do |email|
      @user.email = email
      expect(@user).to be_valid
      expect(@user.errors.any?).to be_falsey
    end 
  end

  it "rejects invalid email format" do
    invalid_emails = %w[user@ex,com USER@exam_ple.com
                      User_Foobar.org U12=3@Example.gov]
    invalid_emails.each do |email|
      @user.email = email
      expect(@user).not_to be_valid
      expect(@user.errors.any?).to be_truthy
    end 
  end

  it "requires unique email" do
    @user.save
    other_user = @user.dup
    expect(other_user).not_to be_valid
    expect(other_user.errors.any?).to be_truthy
  end

  it "requires unique email with no case sensitive" do
    @user.save
    other_user = @user.dup
    other_user.email = @user.email.upcase
    expect(other_user).not_to be_valid
    expect(other_user.errors.any?).to be_truthy
  end

  it "requires email in downcase" do
    @user.email = "FOO@BAR.com"
    @user.save
    email = "foo@bar.com"
    expect(@user.email).to eq(email)
  end

  it "requies password" do
    @user.password = " "
    expect(@user).not_to be_valid
    expect(@user.errors.any?).to be_truthy
  end

  it "requires min length of 8 for password" do
    @user.password = "a"*7
    expect(@user).not_to be_valid
    expect(@user.errors.any?).to be_truthy
  end

  it { should have_many(:posts) }
end