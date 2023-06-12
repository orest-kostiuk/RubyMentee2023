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
    # automatic GC
    TestObject.reset_instance_count
    memory_with_enabled_gc, objects_created_enabled_gc = measure_memory_usage_and_objects_created do
      1_000_000.times { TestObject.new(100) }
    end

    # GC turned off
    GC.disable
    TestObject.reset_instance_count
    memory_with_disabled_gc, objects_created_disabled_gc = measure_memory_usage_and_objects_created do
      1_000_000.times { TestObject.new(100) }
    end
    GC.enable

    # GC called on demand
    GC.disable
    TestObject.reset_instance_count
    memory_with_manual_gc, objects_created_manual_gc = measure_memory_usage_and_objects_created do
      1_000_000.times { TestObject.new(100) }
      GC.start
    end
    GC.enable

    render json: {
      memory_with_enabled_gc: memory_with_enabled_gc,
      objects_created_enabled_gc: objects_created_enabled_gc,
      memory_with_disabled_gc: memory_with_disabled_gc,
      objects_created_disabled_gc: objects_created_disabled_gc,
      memory_with_manual_gc: memory_with_manual_gc,
      objects_created_manual_gc: objects_created_manual_gc
    }
  end

  private

  def measure_memory_usage
    GetProcessMem.new.bytes
  end

  def measure_memory_usage_and_objects_created
    initial_memory = measure_memory_usage
    initial_objects_count = TestObject.instance_count

    yield

    final_memory = measure_memory_usage
    final_objects_count = TestObject.instance_count

    memory_diff = final_memory - initial_memory
    objects_created = final_objects_count - initial_objects_count

    [memory_diff, objects_created]
  end
end