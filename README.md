# Beatmatch

A naive recommendation engine for Discogs.

## How it works

A user has two signals:
  1. Collections
  2. Wantlists

What we want to do is find the relationship between two users given these two factors.  The first is what they *have*, which is the stronger signal.  The next is what they want, which is a milder signal.

Right now the library is split into two support structures: `beatmatcher`, which is the interface component, and `matchmaker`, which is a naive Javascript implementation of similarity indexing.

### The Matchmaker

Eventually I'll be pulling this into its own repository, but for now it goes in the weekend project where I first wrote it!

This is a pretty basic overall look at similarity indexing.  There's a seriously good chance that I have it all wrong, too.  But even if so, the architecture of the pieces is reasonable and tested, so changing and updating it should be simple to do.

The Matchmaker is a pretty simple tool: Give it two entities which have array properties which contain comparable members, and it will compare them for you and summarize the results.

#### Potential improvements to the matchmaker

* Add signal strength support (multipliers which increase or decrease the efficacy of a given signal)
* Move more arithmetic to individual signals.  Make them reduceable.
* Create a limitation mechanism so that avid collectors and hobbyists can be given more genuine comparisons even if one has a collection which dwarfs the other (right now, having a superior sized collection or wantlist will distinguish a user's profile entirely).
* Any time a new measure above is put in, make sure the `#stats()` method call is updated to include unmodified data.

### Advanced aggregation

Although it would be pretty straightforward to create an aggregation engine with the Matchmaker, from the *outside* this isn't possible with the Discogs API.

Aggregation of a massive, cacheable level would take internal (ideally, non-paginated and non-throttled) data access.  For practicality reasons, Discogs can't disclose those aspects of their API publicly.

This application suite instead throttles the throughput deliberately by making it a function of the interface.  The user can not move any faster than it would take to type up the name and enter it into the given forms.

### The Workflow

1. First we prompt for two users.
2. Once each user is entered, we grab an arbitrary amount (no more than 75 items) from that user's collection and wantlist.
3. Once we have the data from both users, we compare it with the Matchmaker.

First blush layout:

![First blush layout](/doc/images/beatmatch-concept.png)

## How to manage a Sojourn development environment

I use a boilerplate start point for all of my application development.  Sinatra, Rails, Express, you name it.  [Sojourn](https://esmevane.github.io/sojourn) is an isomorphic boilerplate starting point.  Made by me, for me: so, there are definitely some quirks!

In a nutshell, here's how to get up and rolling with a Sojourn project.

1. Clone the repository (`git clone git@github.com:esmevane/beatmatch`)
2. Hop into the resulting directory. (`cd beatmatch`)
3. `npm install` and `bundle` (for [Sass](http://sass-lang.com/)) or just `gem install sass` (either one works if you have an installed ruby)
4. `npm install -g grunt-cli` in order to run the `Gruntfile`
5. `grunt serve` in order to start the webserver
6. `grunt test` in order to run the test suite

My typical workflow is to start `grunt serve` in one console window, and `grunt test` in another on demand.

While serving files, a Sojourn environment watches for changes in `assets` (and here, also in `lib`), and recompiles when needed.  This can lead to a few seconds of work time as it rebuilds the central script, and then minifies it, but it is generally pretty quick.

The three major groups for in-points to building software on top of this project:

* **Javascript:** `assets/scripts/application.coffee`, `lib`, and `spec` - The start for building up behavior.  You can use Javascript or plug in ES6 if you want!  The project pays attention to regular `.js` files.  All Javascript files found in `assets/scripts` or `lib` are eligible for eventual browserifying.
* **CSS:** `assets/styles/application.sass` - I also use a lot of the [Bourbon](http://bourbon.io/) ecosystem for quick utility.  I prefer SASS over SCSS, but your mileage may vary, so Sojourn projects compile both.
* **Markup & Servers:** - There is a root file at `server.coffee`, which serves basic assets and accomodates [express](http://expressjs.com/) (version 3 right now) routes.  The actual standard images/fonts/etc., are all found in `app` - though mostly these are meant to be static and only grown deliberately.

A served environment can be found at `http://localhost:9001` provided you're using `grunt serve`.

## How to deploy

I have a copy of the repository available on Docker, at [`esmevane/beatmatch`](https://registry.hub.docker.com/u/esmevane/beatmatch/) - if you want to start up a Beatmatch server, just kick off a Docker friendly environment, pull the repo and run it!  Here's a few helpful commands:

```
docker pull esmevane/beatmatch
docker run -d -p 80:9001 esmevane/beatmatch:latest
```

I've got an example sitting at [beatmatch.esmevane.com](http://beatmatch.esmevane.com/)

## How to test

* `grunt test` to run test scripts.
