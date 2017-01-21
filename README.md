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
2.2.2 :001 > require 'constree/module'
 => true
2.2.2 :002 > require 'minitest/spec'
 => true
2.2.2 :003 > Minitest::Spec.constreep
Minitest::Spec (Class)
├─DSL (Module)
│ ├─TYPES (Array)
│ └─InstanceMethods (Module)
├─TYPES → Minitest::Spec::DSL::TYPES
├─PASSTHROUGH_EXCEPTIONS (Array)
├─TEARDOWN_METHODS (Array)
├─LifecycleHooks (Module)
├─UNDEFINED (Object)
├─E (String)
└─SIGNALS (Hash)
 => nil
```

