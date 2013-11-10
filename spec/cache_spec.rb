require_relative 'spec_helper'

describe Shoestring::Cache do

  describe "caches to file" do
    before { FileUtils.rm_rf('tmp') }

    it "works when tmp folder doesn't exist" do
      Shoestring::Cache.check(:test) do |old_version|
        'cached_value'
      end

      File.exists?('tmp/.test').must_equal true
    end

    it "doesn't run when cache is the same" do
      Shoestring::Cache.check(:test) do |old_version|
        @called = 1
        'cached_value'
      end

      Shoestring::Cache.check(:test) do |old_version|
        version = 'cached_value'
        if version != old_version.strip
          @called = 2
        end
        version
      end

      @called.must_equal 1
    end

    it "reruns when version does not match cache" do
      Shoestring::Cache.check(:test) do |old_version|
        @called = 1
        'cached_value'
      end

      Shoestring::Cache.check(:test) do |old_version|
        version = 'changed_value'
        if version != old_version.strip
          @called = 2
        end
        version
      end

      @called.must_equal 2
    end
  end

end
