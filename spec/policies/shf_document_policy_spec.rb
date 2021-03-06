require 'rails_helper'

RSpec.describe ShfDocumentPolicy do

  let(:user_1) { create(:user, email: 'user@random.com') }
  let(:member) { create(:member_with_membership_app, email: 'member@random.com', company_number: '5562728336')}
  let(:admin)  { create(:user, email: 'admin@shf.se', admin: true) }
  let(:shf_document) { create(:shf_document, uploader: (create(:user, email: 'admin2@shf.se', admin: true )) )}

  subject { described_class }

  describe 'For admin' do
    subject { described_class.new(admin, shf_document) }

    it { is_expected.to permit_action :index }
    it { is_expected.to permit_action :show }
    it { is_expected.to permit_action :edit }
    it { is_expected.to permit_action :update }
    it { is_expected.to permit_action :destroy }
    it { is_expected.to permit_action :new }
    it { is_expected.to permit_action :create }
    it { is_expected.to permit_action :minutes_and_static_pages }

  end


  describe 'For a member' do
    subject { described_class.new(member, shf_document) }

    it { is_expected.to permit_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_action :edit }
    it { is_expected.to forbid_action :update }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to forbid_action :new }
    it { is_expected.to forbid_action :create }
    it { is_expected.to permit_action :minutes_and_static_pages }
  end


  describe 'For a user (registered but not a member)' do
    subject { described_class.new(user_1, shf_document) }

    it { is_expected.to forbid_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_action :edit }
    it { is_expected.to forbid_action :update }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to forbid_action :new }
    it { is_expected.to forbid_action :create }
    it { is_expected.to forbid_action :minutes_and_static_pages }
  end


  describe 'For a visitor (not logged in)' do
    subject { described_class.new(nil, shf_document) }

    it { is_expected.to forbid_action :index }
    it { is_expected.to forbid_action :show }
    it { is_expected.to forbid_action :edit }
    it { is_expected.to forbid_action :update }
    it { is_expected.to forbid_action :destroy }
    it { is_expected.to forbid_action :new }
    it { is_expected.to forbid_action :create }
    it { is_expected.to forbid_action :minutes_and_static_pages }
  end
end
