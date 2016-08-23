require 'spec_helper'

describe 'rbldnsd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        let :params do
          { :zones => 'myzone' }
        end

        context "rbldnsd class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('rbldnsd') }
          it { is_expected.to contain_class('rbldnsd::config') }
          it { is_expected.to contain_class('rbldnsd::install') }
          it { is_expected.to contain_class('rbldnsd::params') }
          it { is_expected.to contain_class('rbldnsd::service') }
          it { is_expected.to contain_file('/etc/default/rbldnsd').with(
            :content => /^RBLDNSD="dnsbl -f \\$/,
            :content => /^\t-b 127.0.0.1 -r \/var\/lib\/rbldns \\$/,
            :content => /^\t-w dnsbl \\$/,
            :content => /^\t-s \+stats.log \\$/,
            :content => /^\t\tmyzone"$/,
            :ensure  => 'present',
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',) }
          it { is_expected.to contain_file('/var/lib/rbldns').with(
            :ensure => 'directory',
            :mode   => '0755',
            :owner  => 'root',
            :group  => 'root',) }
          it { is_expected.to contain_file('/var/lib/rbldns/dnsbl').with(
            :ensure => 'directory',
            :mode   => '0755',
            :owner  => 'rbldns',
            :group  => 'root',) }
          it { is_expected.to contain_package('rbldnsd').with(
            :ensure => 'present',) }
          it { is_expected.to contain_service('rbldnsd').with(
            :ensure     => 'running',
            :hasrestart => 'true',
            :hasstatus  => 'false',
            :pattern    => 'rbldnsd',) }
        end
      end
    end
  end

end
