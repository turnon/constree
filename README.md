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
Minitest::Spec {:kla=>Class, :aft=>[Minitest::Spec::DSL::InstanceMethods, Minitest::Test, Minitest::Guard, Minitest::Test::LifecycleHooks, Minitest::Reportable, Minitest::Assertions, Minitest::Runnable, Object, Minitest::Expectations, Kernel, BasicObject]}
├─DSL {:kla=>Module}
│ ├─InstanceMethods {:kla=>Module}
│ └─TYPES {:kla=>Array}
├─E {:kla=>String}
├─LifecycleHooks {:kla=>Module}
├─PASSTHROUGH_EXCEPTIONS {:kla=>Array}
├─SIGNALS {:kla=>Hash}
├─TEARDOWN_METHODS {:kla=>Array}
├─TYPES {:ref=>"Minitest::Spec::DSL::TYPES"}
└─UNDEFINED {:kla=>Object}
=> nil
```

