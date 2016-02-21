require 'rails_helper'

RSpec.describe Category, type: :model do

  before :each do
    @category = Fabricate(:category, name: "Sports")
  end

  it "requires name" do
    @category.name = " "
    expect(@category).not_to be_valid
    expect(@category.errors[:name].any?).to be_truthy
  end

  it "requires unique name with no case sensitive" do
    @category.save
    other_category = @category.dup
    other_category.name = @category.name.upcase
    expect(other_category).not_to be_valid
    expect(other_category.errors[:name]).to eq(["has already been taken"])
  end

  it "requires name's maximum length of 25" do
    @category.name = "a"*26
    expect(@category).not_to be_valid
    expect(@category.errors[:name]).to eq(["is too long (maximum is 25 characters)"])
  end

  it "requires name's minimum length of 3" do
    @category.name = "a"*2
    expect(@category).not_to be_valid
    expect(@category.errors[:name]).to eq(["is too short (minimum is 3 characters)"])

  end

  it { should have_many(:post_categories) }
  it { should have_many(:posts).through(:post_categories) }
end
