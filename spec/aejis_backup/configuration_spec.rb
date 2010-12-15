require 'spec_helper'

describe AejisBackup::Configuration do

  before :each do
    AejisBackup.config do
      source('mydb', :postgresql) do
        user      'rails'
        password  'password'
        database  'test_production'
      end
      storage('ptico-s3', :s3) do
        access_key_id     'zzzaaa'
        secret_access_key 'secret_access_key'
        host              's3-ap-southeast-1.amazonaws.com'
        bucket            '/bucket/backups/test/'
        use_ssl
      end
      backup(:mybackup) do
        source 'mydb'
        target 'ptico-s3'
      end
    end
    @config = AejisBackup.config
  end

  it "should set adapter" do
    source = @config.sources['mydb']
    source.user.should     eq('rails')
    source.password.should eq('password')
    source.database.should eq('test_production')
  end

  it "should set storage" do
    storage = @config.storages['ptico-s3']
    storage.access_key_id.should eq('zzzaaa')
  end

  it "should configure backups" do
    backup = @config.backups[:mybackup]
    backup.sources.should eq(['mydb'])
    backup.target.should  eq('ptico-s3')
  end
end