class Note
  attr_reader :note_on_ch, :note_off_ch, :note_nr,:velocity ,:probability , :duration, :hash, :array
  def initialize(on_ch, off_ch, note_nr, velocity, probability, duration)
    @note_on_ch=on_ch
    @note_off_ch=off_ch
    @note_nr=note_nr
    @velocity=velocity
    @probability=probability
    @duration=duration
    @hash = {:note_on_ch => @on_ch,:note_off_ch => @off_ch ,:note_nr => @note_nr , :velocity => @velocity,
             :probability => @probability, :duration => @duration}
    @array = @hash.values
  end
end
