require 'rails_helper'

describe Post do
  it { should belong_to(:user) }
  it { should have_many(:images) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
end
