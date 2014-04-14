require 'spec_helper'

#rake db:test:prepare

describe Comment do

  it { should validate_presence_of :content }
  it { should belong_to :hotspot }

end