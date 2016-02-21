require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  before :each do
    @comment = Fabricate(:comment)
  end

  it "requires content" do
    @comment.content = " "
    expect(@comment).not_to be_valid
    expect(@comment.errors.any?).to be_truthy
  end

  it { should belong_to(:post) }
  it { should belong_to(:user) }
  
end