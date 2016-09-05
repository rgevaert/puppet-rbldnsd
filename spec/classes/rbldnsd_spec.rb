require 'spec_helper'


describe 'rbldnsd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "rbldnsd class with only zones parameter" do
          let :params do
            { :zones => 'myzone.example.com:ip4set:inputs'}
          end

          contents = [  'RBLDNSD="dnsbl -f',
                        ' -b 127.0.0.1 ',
                        ' -r /var/lib/rbldns ',
                        ' -w dnsbl ',
                        ' -s \+stats.log ',
                        ' myzone.example.com:ip4set:inputs' ]
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('rbldnsd') }
          it { is_expected.to contain_class('rbldnsd::config') }
          it { is_expected.to contain_class('rbldnsd::install') }
          it { is_expected.to contain_class('rbldnsd::params') }
          it { is_expected.to contain_class('rbldnsd::service') }

          contents.each do |c|
            it { is_expected.to contain_file('/etc/default/rbldnsd').with(
              :content => /#{c}/,) }
          end
          it { is_expected.to contain_file('/etc/default/rbldnsd').with(
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

        context "rbldnsd class with parameters" do
          let :params do
            { :zones => 'myzone.example.com:ip4set:inputs',
              :ip => '1.1.1.1',
              :root => '/tmp',
              :workingdir => 'workingdir',
              # Not implemented
              #:log => 'foo.log',
              :stats => 'stat.log',
              :acl => 'acls',
              :ensure => 'absent',
              :package => 'otherpackage',
              :servicename => 'rbldnsdservice',
              :service_ensure => 'stopped',
            }
          end

          contents = [  'RBLDNSD="dnsbl -f',
                        ' -b 1.1.1.1 ',
                        ' -r /tmp ',
                        ' -w workingdir ',
                        ' -s \+stat.log ',
                        ' :acl:acls ',
                        ' myzone.example.com:ip4set:inputs' ]
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_file('/etc/default/rbldnsd').with(
            :ensure  => 'present',
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',) }
          contents.each do |c|
            it { is_expected.to contain_file('/etc/default/rbldnsd').with(
              :content => /#{c}/,) }
          end
          it { is_expected.to contain_package('otherpackage').with(
            :ensure => 'absent',) }
          it { is_expected.to contain_service('rbldnsdservice').with(
            :ensure     => 'stopped',) }
          it { is_expected.to contain_file('/tmp').with(
            :ensure => 'directory',
            :mode   => '0755',
            :owner  => 'root',
            :group  => 'root',) }
          it { is_expected.to contain_file('/tmp/workingdir').with(
            :ensure => 'directory',
            :mode   => '0755',
            :owner  => 'rbldns',
            :group  => 'root',) }
        end
      end
    end
  end

end
