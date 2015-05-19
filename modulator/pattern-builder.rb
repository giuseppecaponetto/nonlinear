require_relative '../lib/modules/functions.rb'

module PatternBuilder
  class Step
    attr_accessor :hash
    def initialize(state=0, velocity=0, probability=0)
      self.hash = {:state=>state, :velocity=>velocity, :probability=>probability}
    end
    def to_custom_string
      output = String.new
      hash.each {|key, value| output<< "[#{value}]" }
      output
    end
  end
  
  class Channel
    include ChannelFunctions
    attr_accessor :name, :array
    def initialize(name, steps)
      self.name = name
      self.array = Array.new(steps, nil)
      populate
    end
    
    def to_custom_string
      output = name+": "
      array.each do |element|
        output << "[#{element.to_custom_string}]"
      end
      output 
    end
    private
    def populate
      array.each_index do |index|
        array[index] = Step.new
      end
    end
    def every num
      (0..array.size).step(num).each do |index|
        array[index] = Step.new(1, 127, 100)
      end
    end
  end

  class Pattern
    attr_accessor :name, :description, :channels, :steps
    
    def initialize name, description="No description availabe", steps, &block 
      self.steps = steps
      self.name = name
      self.description = description
      self.channels = []
      instance_eval(&block)
    end
    
    def to_custom_string
      output = "Pattern name: " + name + "\n"
      output << "Description: #{description} \n"
      output << "Number of steps: " + steps.to_s + "\n"
      output << "Channel/pad number: #{channels.size} \n"
      channels.each_with_index do |index|
        output << index.to_custom_string + "\n"
      end
      output
    end
    
    private
    def channel(name, &options)
      channel = Channel.new(name, steps)
      channel.instance_eval(&options)
      channels << channel
    end
    alias_method :pad, :channel
  end
end