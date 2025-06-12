require 'test/unit'
require 'yaml'

class AuthorMetadataTest < Test::Unit::TestCase
  def test_post_author_metadata
    post_path = '_posts/2023-06-15-welcome-to-jekyll.md'
    assert(File.exist?(post_path), "Sample post file should exist")
    
    # Read the front matter
    content = File.read(post_path)
    front_matter = YAML.load_stream(content).first
    
    # Check author metadata fields
    assert(front_matter['author'], "Post should have author metadata")
    assert_not_nil(front_matter['author']['name'], "Author name should be present")
    assert_not_nil(front_matter['author']['bio'], "Author bio should be present")
  end

  def test_config_default_author
    config_path = '_config.yml'
    assert(File.exist?(config_path), "Configuration file should exist")
    
    config = YAML.load_file(config_path)
    assert(config['author'], "Site should have default author configuration")
    assert_not_nil(config['author']['name'], "Default author name should be present")
  end

  def test_author_metadata_structure
    post_path = '_posts/2023-06-15-welcome-to-jekyll.md'
    content = File.read(post_path)
    front_matter = YAML.load_stream(content).first

    # Check that optional fields are supported
    assert_includes(front_matter['author'].keys, 'name')
    assert_includes(front_matter['author'].keys, 'bio')
    assert_includes(front_matter['author'].keys, 'email')
    assert_includes(front_matter['author'].keys, 'twitter')
  end
end