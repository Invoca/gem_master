require 'test_helper'
require 'gem_master'

describe GemMaster::GemfileMixin do
  include GemMaster::GemfileMixin

  before do
    @gems = []
  end

  def gem(*args)
    @gems << args
  end

  it "should pass gem command through" do
    gem "paperclip", "2.1.3"

    assert_equal [["paperclip", "2.1.3"]], @gems
  end

  it "should have an mgem command" do
    self.gem_master_filename = "./test/samples/Gemfile.master"
    mgem "nokogiri"
    mgem "rake"

    assert_equal [['nokogiri', '1.8.1'], ['rake', '10.3.2', git: 'git@github.com:Invoca/rake', ref: '01ef2a598d9fb260310f9e08f74486407d4eab83']],
      @gems
  end

  it "should merge options to mgem when present" do
    self.gem_master_filename = "./test/samples/Gemfile.master"
    mgem "nokogiri"
    mgem "rake", require: false

    assert_equal [['nokogiri', '1.8.1'], ['rake', '10.3.2', git: 'git@github.com:Invoca/rake', ref: '01ef2a598d9fb260310f9e08f74486407d4eab83', require: false]],
                 @gems
  end

  it "should add options to mgem when missing" do
    self.gem_master_filename = "./test/samples/Gemfile.master"
    mgem "nokogiri", require: true
    mgem "rake"

    assert_equal [['nokogiri', '1.8.1', require: true], ['rake', '10.3.2', git: 'git@github.com:Invoca/rake', ref: '01ef2a598d9fb260310f9e08f74486407d4eab83']],
                 @gems
  end
end
