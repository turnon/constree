# Constree

Recursively show the structure of constants in a module

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'constree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install constree

## Example: constants in Minitest::Spec

```ruby
irb(main):001:0> require 'minitest/spec'
=> true
irb(main):002:0> Constree.p Minitest::Spec
Minitest::Spec < Minitest::Spec::DSL::InstanceMethods < Minitest::Test < Minitest::Guard < Minitest::Test::LifecycleHooks < Minitest::Reportable < Minitest::Assertions < Minitest::Runnable < Object < Minitest::Expectations < Kernel < BasicObject
├─DSL (Module)
│ ├─InstanceMethods (Module)
│ └─TYPES (Array)
├─TYPES → Minitest::Spec::DSL::TYPES
├─PASSTHROUGH_EXCEPTIONS (Array)
├─TEARDOWN_METHODS (Array)
├─LifecycleHooks (Module)
├─E (String)
├─UNDEFINED (Object)
└─SIGNALS (Hash)
=> nil
```

