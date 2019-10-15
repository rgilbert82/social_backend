require 'rails_helper'

describe Image do
  it { should validate_presence_of(:image_url) }
  it { should belong_to(:user) }
  it { should belong_to(:album).optional }
  it { should belong_to(:post).optional }
  it { should have_many(:comments)}
end
