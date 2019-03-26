require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'tor::daemon::control', :type => 'define' do
  let(:default_facts) {
    {
      :osfamily        => 'Debian',
      :operatingsystem => 'Debian',
    }
  }
  let(:title){ 'test_os' }
  let(:facts){ default_facts }
  let(:pre_condition){'Exec{path => "/bin"}
                      include ::tor' }
  describe 'with standard' do
    let(:params){
      {
        :hashed_control_password => '16:6DE8179E17B2161B60AD488A1B39EF7AF682FA4AB51B2E0C8891464880',
        :port                    => 443,
      }
    }
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_concat__fragment('04.control.test_os').with(
      :order   => '04',
      :target  => '/etc/tor/torrc',
    )}
    context 'with cookie auth file' do
      let(:params){
        {
          :cookie_authentication => true,
          :cookie_auth_file      => '/etc/tor/foobar',
          :port                  => 443,
        }
      }
      it { is_expected.to compile.with_all_deps }
    end
    context 'with cookie auth file world redable' do
      let(:params){
        {
          :cookie_authentication           => true,
          :cookie_auth_file_group_readable => true,
          :cookie_auth_file                => '/etc/tor/foobar',
          :port                            => 443,
        }
      }
      it { is_expected.to compile.with_all_deps }
    end
  end
end
