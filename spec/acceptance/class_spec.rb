require 'spec_helper_acceptance'

describe 'rbldnsd class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'rbldnsd': zones => 'bl.example.com:ip4set:inputs' }
      # Set up dummy zone
      file {
        '/var/lib/rbldns/dnsbl/inputs':
          ensure => present,
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => false)
      apply_manifest(pp, :catch_failures => true)
    end

    describe user('rbldns') do
        it { should exist }
    end

    describe package('rbldnsd') do
      it { should be_installed }
    end

    describe service('rbldnsd') do
      it { should be_enabled }
      it { should be_running }
    end

    describe file('/etc/default/rbldnsd') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root'}
      it { should be_grouped_into 'root'}
    end

    describe file('/var/lib/rbldns') do
      it { should be_directory }
      it { should be_mode 755 }
      it { should be_owned_by 'root'}
      it { should be_grouped_into 'root'}
    end

    describe file('/var/lib/rbldns/dnsbl') do
      it { should be_directory }
      it { should be_mode 755 }
      it { should be_owned_by 'rbldns'}
      it { should be_grouped_into 'root'}
    end

    describe port(53) do
      it { should be_listening.with('udp') }
    end
  end
end
