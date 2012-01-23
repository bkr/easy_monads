# Easy Monads - Monads for Ruby, with Option

## EasyMonads::Monadic

Created to provide an easy implementation of monads for Ruby.  Monads are practical and easy to grok (or at least they should be).  Here is an excellent tutorial that explains some of the benefits of monads: [monads-are-not-metaphors](http://www.codecommit.com/blog/ruby/monads-are-not-metaphors).

## EasyMonads::Option

Inspiration for easy_monads largely comes from Scala's Option, and Option is implemented here.  The goal of EasyMonad::Option isn't to mirror Scala's implementation, but it tries to follow the general pattern.  If you are a Scala fan and are looking for Scala semantics in Ruby applications, you should have a look at [rumonade](https://github.com/ms-ati/rumonade) in addition to easy_monads. If you are just looking for an easy implentation of Option for Ruby, EasyMonads::Option is an excellent choice.

To add Option to the Object class:

```ruby
require 'easy_monads'
EasyMonads.option_everywhere!
```

# Credits

Easy Monads is maintained by [Stephen Sloan](https://github.com/SteveSJ76) and is funded by [BookRenter.com](http://www.bookrenter.com "BookRenter.com"). We are experimenting with monads at BookRenter and hope that you find this useful.

![BookRenter.com Logo](http://assets0.bookrenter.com/images/header/bookrenter_logo.gif "BookRenter.com")

# Copyright

Copyright (c) 2011 Stephen Slaon, Bookrenter.com. See LICENSE.txt for further details.