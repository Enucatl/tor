require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'tor', :type => 'class' do
  let(:facts) do
  {
    'os' => {
      'family'  => 'RedHat',
    },
    'operatingsystem' => 'CentOS',
  }
  end
  let(:pre_condition){'Exec{path => "/bin"}' }
  describe 'with standard' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('tor::install') }
    it { is_expected.to contain_class('tor::daemon::base') }
    it { is_expected.to contain_package('tor').with_ensure('installed') }
    it { is_expected.to contain_service('tor').with(
      :ensure     => 'running',
      :enable     => 'true',
      :hasrestart => 'true',
      :hasstatus  => 'true',
      :require    => 'Package[tor]',
    ) }
    context 'on Debian' do
      let(:facts) do
      {
        'os' => {
          'family'  => 'Debian',
        },
        'operatingsystem' => 'Debian',
      }
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('tor::install') }
      it { is_expected.to contain_class('tor::daemon::base') }
      it { is_expected.to contain_package('tor').with_ensure('installed') }
      it { is_expected.to contain_service('tor').with(
        :ensure     => 'running',
        :enable     => 'true',
        :hasrestart => 'true',
        :hasstatus  => 'true',
        :require    => 'Package[tor]',
      ) }
    end
  end
end
