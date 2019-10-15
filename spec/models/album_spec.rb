require 'rails_helper'

describe Album do
  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:images) }
end
