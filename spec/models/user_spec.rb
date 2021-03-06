require 'rails_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:event_invites).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:sent_messages).dependent(:destroy) }
  it { should have_many(:received_messages).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:inverse_friendships).dependent(:destroy) }
  it { should have_many(:friends) }
  it { should have_many(:inverse_friends) }
  it { should have_many(:sent_conversations).dependent(:destroy) }
  it { should have_many(:received_conversations).dependent(:destroy) }
end
