class GcTestController < ApplicationController
  class TestObject
    attr_accessor :value

    @@instance_count = 0

    def self.instance_count
      @@instance_count
    end

    def self.reset_instance_count
      @@instance_count = 0
    end

    def initialize(value)
      @value = value
      @large_array = Array.new(10) { rand(100) }
      @@instance_count += 1
    end
  end

  def generate_objects
    gc_stats = {}

    # automatic GC
    gc_stats[:enabled] = perform_test_with_gc_mode(:enabled)

    # GC turned off
    gc_stats[:disabled] = perform_test_with_gc_mode(:disabled)

    # GC called on demand
    gc_stats[:manual] = perform_test_with_gc_mode(:manual)

    render json: gc_stats
  end

  private

  def perform_test_with_gc_mode(gc_mode)
    TestObject.reset_instance_count
    initial_memory = measure_memory_usage
    initial_objects_count = TestObject.instance_count

    case gc_mode
    when :enabled
      1_000_000.times { TestObject.new(100) }
    when :disabled
      GC.disable
      1_000_000.times { TestObject.new(100) }
      GC.enable
    when :manual
      GC.disable
      1_000_000.times { TestObject.new(100) }
      GC.start
      GC.enable
    end

    final_memory = measure_memory_usage
    final_objects_count = TestObject.instance_count

    memory_diff = final_memory - initial_memory
    objects_created = final_objects_count - initial_objects_count

    { memory_diff: memory_diff, objects_created: objects_created }
  end

  def measure_memory_usage
    GetProcessMem.new.bytes
  end
end