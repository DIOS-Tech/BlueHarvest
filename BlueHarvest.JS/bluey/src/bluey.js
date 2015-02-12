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

  var Login = React.createClass({
    displayName: "Login",
    userNameHandler: function (e) {
      this.setState({ userName: e.target.value });
    },
    passwordHandler: function (e) {
      this.setState({ password: e.target.value });
    },
    submitHandler: function (e) {},
    render: function () {
      return React.createElement(
        "div",
        { className: "login-container" },
        React.createElement(
          "div",
          { className: "login-container-title" },
          "Blue Harvest"
        ),
        React.createElement(
          "span",
          null,
          "Username:"
        ),
        React.createElement("br", null),
        React.createElement("input", { type: "text", onChange: this.userNameHandler }),
        React.createElement("br", null),
        React.createElement(
          "span",
          null,
          "Password:"
        ),
        React.createElement("br", null),
        React.createElement("input", { type: "password", onChange: this.passwordHandler }),
        React.createElement("br", null),
        React.createElement("br", null),
        React.createElement("input", { type: "submit", className: "login-submit-button", onClick: this.submitHandler })
      );
    }
  });

  $(document).ready(function () {
    browser.openDevTools();

    /*<QuickLaunch items={quickLaunchItems} />,*/
    React.render(React.createElement(Login, null), document.getElementById("ui"));
  });

  return my;
})(jQuery);

module.exports = Bluey;
// do something here so that the user is logged in

