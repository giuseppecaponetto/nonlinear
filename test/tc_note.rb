require_relative '../lib/Note.rb'
require 'test/unit'

class TestNote < Test::Unit::TestCase
  def test_note_structure
    note = Note.new(144, 128, 36, 100, 59, 200)
    assert_equal(144, note.note_on_ch)
    assert_equal(128, note.note_off_ch)
    assert_equal(36, note.note_nr)
    assert_equal(100, note.velocity)
    assert_equal(59, note.probability)
    assert_equal(200, note.duration)
  end
end
