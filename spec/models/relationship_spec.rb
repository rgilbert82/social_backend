require 'rails_helper'

describe Relationship do
  it { should belong_to(:user) }
  it { should belong_to(:relation) }
end
