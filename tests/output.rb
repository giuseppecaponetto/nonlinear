#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))
require 'rubygems'
require 'bundler/setup'
require "micromidi"

# This example sends some messages to an output selected by the user

output = UniMIDI::Output.gets

MIDI.using(output) do
  note "C4"
  cc 5, 120
  play "C2", 3
end