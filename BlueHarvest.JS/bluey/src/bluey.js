"use strict";

var Bluey = (function ($) {
  "use strict";

  var my = {};

  var remote = require("remote"),
      browser = remote.getCurrentWindow();

  var quickLaunchItems = [{
    id: 0,
    text: "Administration",
    click: function () {
      alert("You clicked on Administration");
    }
  }, {
    id: 1,
    text: "Daily Schedule",
    click: function () {
      alert("You clicked on Daily Schedule");
    }
  }, {
    id: 2,
    text: "Vacation Requests",
    click: function () {
      alert("You clicked on Vacation Requests");
    }
  }, {
    id: 3,
    text: "Employee Data",
    click: function () {
      alert("You clicked on Employee Data");
    }
  }, {
    id: 4,
    text: "Employee Tasks",
    click: function () {
      alert("You clicked on Employee Tasks");
    }
  }];

  var QuickLaunch = React.createClass({
    displayName: "QuickLaunch",
    render: function () {
      var items = this.props.items.map(function (i) {
        return React.createElement(
          "div",
          { key: i.id, onClick: i.click, className: "quick-launch-item" },
          i.text
        );
      });

      return React.createElement(
        "div",
        { className: "quick-launch-container" },
        items
      );
    }
  });

  $(document).ready(function () {
    browser.openDevTools();

    React.render(React.createElement(QuickLaunch, { items: quickLaunchItems }), document.getElementById("ui"));
  });

  return my;
})(jQuery);

module.exports = Bluey;

