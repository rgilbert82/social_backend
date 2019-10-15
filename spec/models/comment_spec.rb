require 'rails_helper'

describe Comment do
  it { should validate_presence_of(:body) }
  it { should belong_to(:user) }
  it { should belong_to(:post).optional }
  it { should belong_to(:image).optional }
  it { should belong_to(:event).optional }
end
