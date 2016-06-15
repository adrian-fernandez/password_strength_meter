Password Strength Meter
===============

Ruby gem designed to help quantify the quality of a username / password pair.

It takes care about user and password similarity (based on jaro winkler algorithm) and the password complexity:
- Length
- Capital letters
- Small letters
- Numbers
- Special characters

Installation
------------

Add this into your Gemfile and then run bundle install

    gem "PasswordStrengthMeter"

Usage
-----

This gem provides evaluate(user, pass) method.

```erb
  PasswordStrengthMeter.evaluate('john', 'johndoe')
```

## Author
---------

Adrián Fernández <adrian@adrian-fernandez.net>

[http://www.adrian-fernandez.net](http://www.adrian-fernandez.net)

[@adrian-fernandez](https://twitter.com/adrianfdez14)


