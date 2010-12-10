require 'spec_helper'

describe AejisBackup::Configuration do
  it "should set adapter" do
    config = AejisBackup::Configuration.new do
      source('mydb', :postgresql) do
        user      'rails'
        password  'password'
        database  'test_production'
      end
    end
    source = config.sources['mydb']
    source.user.should     eq('rails')
    source.password.should eq('password')
    source.database.should eq('test_production')
  end

  it "should set storage" do
    config = AejisBackup::Configuration.new do
      storage('ptico-s3', :s3) do
        access_key_id     'zzzaaa'
        secret_access_key 'secret_access_key'
        host              's3-ap-southeast-1.amazonaws.com'
        bucket            '/bucket/backups/test/'
        use_ssl
      end
    end
    storage = config.storages['ptico-s3']
    storage.access_key_id.should eq('zzzaaa')
  end
end