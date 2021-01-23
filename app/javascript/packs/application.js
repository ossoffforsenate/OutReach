// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import ConfettiGenerator from "confetti-js";

window.addEventListener('DOMContentLoaded', (event) => {
  const confettiCanvas = document.getElementById('confetti-canvas')
  try {
    if (confettiCanvas && typeof CSS === "function" && typeof CSS.supports === "function" && CSS.supports("( pointer-events: none )")) {
      const confettiSettings = { target: confettiCanvas, max: 120, respawn: false, clock: 35 };
      const confetti = new ConfettiGenerator(confettiSettings);
      confetti.render()
    } else if (confettiCanvas && confettiCanvas !== undefined) {
      // to avoid breaking people's page, only show confetti if browser supports
      // pointer-events: none
      confettiCanvas.remove()
    }
  } catch(err) {
    console.log('confetti error');
    console.log(err);
  }

  const video_closers = document.querySelectorAll(".close-video")
  for (const video_closer of video_closers) {
    video_closer.addEventListener('click', function () {
      let video_modal = document.getElementById("video");
      if (video_modal !== undefined) {
        video_modal.classList.remove("is-active");
        video_modal.remove();
      }
    });
  }

  // For fluid width youtube and vimeo embeds
  (function (window, document, undefined) {
    "use strict";

    // List of Video Vendors embeds you want to support
    var players = ['iframe[src*="youtube.com"]', 'iframe[src*="vimeo.com"]'];

    // Select videos
    var fitVids = document.querySelectorAll(players.join(","));
    try {
      // If there are videos on the page...
      if (fitVids.length) {
        // Loop through videos
        for (var i = 0; i < fitVids.length; i++) {
          // Get Video Information
          var fitVid = fitVids[i];
          var width = fitVid.getAttribute("width");
          var height = fitVid.getAttribute("height");
          var aspectRatio = height / width;
          var parentDiv = fitVid.parentNode;

          // Wrap it in a DIV
          var div = document.createElement("div");
          div.className = "fitVids-wrapper";
          div.style.paddingBottom = aspectRatio * 100 + "%";
          parentDiv.insertBefore(div, fitVid);
          fitVid.remove();
          div.appendChild(fitVid);

          // Clear height/width from fitVid
          fitVid.removeAttribute("height");
          fitVid.removeAttribute("width");
        }
      }
    } catch(err) {
      console.log('fitvids error');
      console.log(err);
    }
  })(window, document);
});



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
