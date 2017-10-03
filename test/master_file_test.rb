require 'test_helper'
require 'gem_master'

describe GemMaster::MasterFile do
  describe "when constructed" do
    before do
      @gem_master = GemMaster::MasterFile.new("test/samples/Gemfile.master")
    end

    it "should parse each gem" do
      assert_equal 7, @gem_master.gems.size
    end

    it "should parse gem with no version" do
      assert_equal [], @gem_master.gems["activerecord-import"]
    end

    it "should parse gem with simple version" do
      assert_equal ["1.8.5"], @gem_master.gems["memcache-client"]
    end

    it "should parse gem with version and hash of options" do
      assert_equal ["~> 1.0.1", {git: 'git@github.com:Invoca/boolean_expression', ref: 'f588e1a97720d828df1e7ae5927f0484274a1190'}],
                   @gem_master.gems["boolean_expression"]
    end
  end
end
