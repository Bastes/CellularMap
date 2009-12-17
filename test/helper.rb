require 'rubygems'
require 'test/unit'
require 'shoulda'
 
ROOT = File.join(File.dirname(__FILE__), '..')
 
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'map')
 
require File.join(ROOT, 'lib', 'map')
