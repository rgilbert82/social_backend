require 'rails_helper'

describe Conversation do
  it { should validate_presence_of(:title) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should have_many(:messages) }
end
