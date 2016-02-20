require 'rails_helper'

RSpec.describe Post, type: :model do
  
  before :each do
    @post = Fabricate(:post)
  end

  it "requires title" do
    @post.title = " "
    expect(@post).not_to be_valid
    expect(@post.errors[:title]).to eq(["can't be blank"])
  end

  it "requires description" do
    @post.description = " "
    expect(@post).not_to be_valid
    expect(@post.errors[:description]).to eq(["can't be blank"])
  end

end