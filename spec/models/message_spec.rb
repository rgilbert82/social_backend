require 'rails_helper'

describe Message do
  it { should validate_presence_of(:body) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should belong_to(:conversation) }
end
