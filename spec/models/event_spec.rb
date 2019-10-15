require 'rails_helper'

describe Event do
  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:event_invites).dependent(:destroy) }
end
