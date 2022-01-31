<div align="center">
  <img src="app/assets/images/logo_readme.png"/>
  <h1>OutReach: VPB for your Reach Contacts</h1>
</div>

OutReach is a tool to build a virtual phonebank on top of your [Reach](https://www.reach.vote) data. It was
prototyped quickly in the final week of the Ossoff 2020 GA Senate run-off, and
is currently very tightly-coupled to the data pipeline for that campaign and
untested.

A public demo is available [here](https://outreach-vote-demo.herokuapp.com/). (Note: because the demo uses the heroku free tier, it may take a minute or so for the first page load)

For now, this repo is just provided for reference and to fork for
future campaigns. In the future, it can be abstracted to support any campaign
using Reach.

**Some basic documentation will be provided in the future, though the amount of
effort spent on this will depend on interest from other campaigns. If you're
interested in using this, please email me at benmuschol@gmail.com**

## Current State

The current state of the codebase is not totally usable by other campaigns,
though it could be with some adjustment. For the most part, the functionality
here is meant to be a UX improvement ontop of reach for relational
phone/textbanking events, so you may have better luck simply using reach on its
own rather than trying to deploy outreach.

That said, to set it up for another campaign, the work should focus around:
 - Graphics: The homepage features a photo of Jon Ossoff which should be rotated
   in favor of a photo of your candidate
 - Data pipeline: The data pipeline is currently tightly-coupled to the Ossoff
   campaign's data. Though most of the data is essentially directly from the
   Reach API, it was imported via BigQuery, so there is no implementation to
   load data from Reach directly. Additionally, some data around voter scores or
   polling places was loaded from non-Reach data pipelines. The codebase should
   be modified to work with null values in that instance or import them through
   some other source.

The app comes with fake data to use and play around with for development
purposes so you can set it up without this data pipeline for testing, but it
will take effort to use it in production.

## Tech Stack / Dependencies

In addition to the BigQuery dependency mentioned above, you will need to set up
the Twilio API for login.

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
