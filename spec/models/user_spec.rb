require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Example User", :email => "user@email.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require name" do 
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject a duplicate email address" do
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject a duplicate email with different case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
    
end
