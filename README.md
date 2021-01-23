<div align="center">
  <img src="app/assets/images/logo_readme.png"/>
  <h1>OutReach: VPB for your Reach Contacts</h1>
</div>

OutReach is a tool to build a virtual phonebank ontop of your Reach.vote data. It was
prototyped quickly in the final week of the Ossoff 2020 GA Senate run-off, and
is currently very tightly-coupled to the data pipeline for that campaign and
untested.

For now, this repo is just provided for reference and to fork for
future campaigns. In the future, it can be abstracted to support any campaign
using Reach.

**Some basic documentation will be provided in the future, though the amount of
effort spent on this will depend on interest from other campaigns. If you're
interested in using this, please email me at benmuschol@gmail.com**

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

## Deployment

This app is deployed using heroku. Each PR will get a review app which it can
test changes on.

## Acknowledgements

In addition to the people who have comitted code to this repo, we are thankful
for the contributions of [Cat Audi](https://www.thecataudi.com/), who designed
all of the front-end elements, and [Joshua Kravitz](https://joshuakravitz.com/),
who built the data pipelines which power this application.
