require 'rails_helper'

describe EventInvite do
  it { should belong_to(:user) }
  it { should belong_to(:event) }
end
