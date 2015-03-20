# Beatmatch

A naive recommendation engine for Discogs.

## How it works

A user has two signals:
  1. Collections
  2. Wantlists

To find out how similar a user is to another user, we use this formula:

1. Get a user's collection and wishlist
2. Get another user's collection and wishlist
3. Count similarities between U1C and U2C
4. Count differences between U1C and U2C
5. Divide similarities by differences
6. Repeat for wants

## Installation

```
git clone git@github.com:esmevane/beatmatch
cd beatmatch
npm install
gem install sass
grunt serve
```

Then visit `http://localhost:9001`

## How to test

* `grunt test` to run test scripts.
