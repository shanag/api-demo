require 'spec_helper'

describe AppStatus do
  subject { create(:app_status) }

  it { should validate_presence_of :status }
  it { should ensure_inclusion_of(:status).in_array(%w(UP DOWN)) }
end
